const hexstr = (str) => str.length % 2 == 0 ? str : `${str}0`;

const datafromhex = (str) => {
  const a = Uint8Array.fromHex(hexstr(str));
  const res = [];
  let i = 0;
  for (let y = 0; y < 8; y++) {
    const row = [];
    for (let x = 0; x < 8; x += 4) {
      const v = a[i] || 0;
      row.push(v >> 6);
      row.push((v >> 4) & 0b00000011);
      row.push((v >> 2) & 0b00000011);
      row.push(v & 0b00000011);
      i++;
    }
    res.push(row);
  }
  return res;
};

const palfromhex = (str) => {
  const a = Uint8Array.fromHex(hexstr(str));
  const res = [];
  let i = 0;
  for (let x = 0; x < 8; x++) {
    const v = a[i] || 0;
    res.push(v >> 4);
    res.push(v & 0b00001111);
    i++;
  }
  return res;
};

const array = (len, gen) => Array(len).fill(0).map(gen);

const hexes = "0123456789abcdef";
const rhex = (len) => () => array(len, () => hexes[Math.trunc(Math.random() * 16)]).join("");

const fullpal =
  [
    "#000000", "#1D2B53", "#7E2553", "#008751",
    "#AB5236", "#5F574F", "#C2C3C7", "#FFF1E8",
    "#FF004D", "#FFA300", "#FFEC27", "#00E436",
    "#29ADFF", "#83769C", "#FF77A8", "#FFCCAA"];

let pals;
let sprites;

const offcanvas = new OffscreenCanvas(256, 256);
const offctx = offcanvas.getContext("2d");
offctx.imageSmoothingEnabled = false;
let offready = false;

const drawgfx = (ctx, dx, dy, palhex, sprhex) => {
  const pal = palfromhex(palhex);
  const data = datafromhex(sprhex);
  const transparent = pal[0] === pal[1];
  data.forEach(
    (row, y) => row.forEach(
        (i, x) => {
          if (i > 0 || !transparent) {
            ctx.fillStyle = fullpal[pal[i]];
            ctx.fillRect(dx + x, dy + y, 1, 1);
          }
        }
    ));
};

let canvas;
let ctx;
let map;
let legend;

const offrender = () => {
  if (offready) {
    return;
  }
  offctx.clearRect(0, 0, 256, 256);
  for (let si = 0; si < 32; si++) {
    for (let pi = 0; pi < 4; pi++) {
      drawgfx(offctx, si * 8, pi * 8, pals[pi], sprites[si]);
    }
  }
  offready = true;
};

const params = (str) => [... str.matchAll(/[^\s]+/g)].map(a => a[0]);


let scale = 4;
let flipx = null;
let flipy = null;

const flip = (fx, fy) => {
  // if (fx === flipx && fy === flipy) return;
  const f = (i, b) => b ? -i : i;
  ctx.setTransform(f(4, fx), 0, 0, f(4, fy), 0, 0);
  flipx = fx;
  flipy = fy;
};

const draw = (s, p, x, y) => {
  const f = (i, b) => b ? -i - 8 : i;
  ctx.drawImage(offcanvas, s * 8, p * 8, 8, 8, f(x, flipx), f(y, flipy), 8, 8);
};

const start = (filecontent) => {
  
  const elem = (tagName, props, ...children) => {
    const el = Object.assign(document.createElement(tagName), props);
    el.replaceChildren(...children);
    return el;
  };

  const editor = document.getElementById("editor");
  const result = document.getElementById("result");
  const autorun = document.getElementById("autorun");
  const url = window.location.href.split('?')[0];
  
  let module;
  const runLua = () => {
    clearTimeout(yieldTimer);
    map = [];
    legend = new Map();
    canvas = elem("canvas", {});
    result.replaceChildren(canvas, elem("pre", { className: "output" }));
    canvas.width = 800;
    canvas.height = 600;
    ctx = canvas.getContext("2d");
    ctx.imageSmoothingEnabled = false;
    flip(false, false);
    pals = array(4, rhex(4));
    sprites = array(32, rhex(32));
    offready = false;
    const str = editor.value;
    module.ccall("run_lua", "number", ["string", "string"], [luarun, str]);
  };
  let yieldTimer;
  let timer;
  let dirty = true;
  const modified = (countdown) => {
    dirty = true;
    clearTimeout(timer);
    if (autorun.checked) {
      timer = setTimeout(runLua, countdown);
    }
  };

  const luaplain = `return function(f) return f() end`;
  const luarun = `return web.run`;
  const luaresume = `return web.resume`;
  const luastr = str => `[[${str.replace("]]", "__")}]]`;
  
  const printelem = () => elem("pre", { className: "output" });
  
  const print = (...args) => {
    result.lastElementChild.append(elem("samp", {}, args.join(" ")), "\n");
  };

  const html = (el) => {
    const last = result.lastElementChild;
    if (last.childNodes.length === 0) {
      last.remove();
    }
    result.append(el, elem("pre", { className: "output" }));
  };


  const config = {
    print: print,
    printErr: print,
    send: (code, payload) => {
      if (code === "return" || code === "error") {
        if (payload !== "") {
          print(`${code}: ${payload}`);
        }
      } else if (code === "html") {
        const div = elem("div");
        div.innerHTML = payload;
        html(div)
      } else if (code === "title") {
        document.title = payload;
      } else if (code === "log") {
        console.log(payload);
      } else if (code === "require") {
        const [_, url, file] = payload.match(/([^\s]+)\s+(.+)/);
        const xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = () => {
          if (xmlHttp.readyState === 4) {
            let code = "";
            if (xmlHttp.status === 200) {
              module.FS.writeFile(file, new Uint8Array(xmlHttp.response));
            } else {
              const err = `${xmlHttp.status}: ${xmlHttp.statusText} (${payload})`;
              code = `error(${luastr(err)})`;
            }
            module.ccall("run_lua", "number", ["string", "string"], [luaresume, code]);
          }
        };
        xmlHttp.responseType = "arraybuffer";
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
      } else if (code == "file") {
        const named = payload !== ""
        const label = named ? `${payload}: ` : "Load file: ";
        const input = elem("input", { type: "file" });
        input.onchange = () => {
          for (const file of input.files) {
            const reader = new FileReader();
            reader.onloadend = () => {
              module.FS.writeFile(named ? payload : file.name, new Uint8Array(reader.result));
              modified(0);
            }
            reader.readAsArrayBuffer(file);
          }
        };
        html(elem("div", {}, label, input));
      } else if (code === "defgfx") {
        const p = params(payload);
        sprites[parseInt(p[0])] = p[1];
        offready = false;
      } else if (code === "defpal") {
        const p = params(payload);
        pals[parseInt(p[0])] = p[1];
        offready = false;
      } else if (code === "gfx") {
        const par = params(payload);
        offrender();
        flip(par[4] == "x" || par[4] == "xy", par[4] == "y" || par[4] == "xy");
        draw(parseInt(par[0]), parseInt(par[1]), parseInt(par[2]), parseInt(par[3]));
      } else if (code === "legend") {
        const p = params(payload.substring(1));
        legend.set(payload[0], { gfxnum: parseInt(p[0]), palnum: parseInt(p[1]) });
      } else if (code === "row") {
        map.push(payload.split(""));
      } else if (code === "map") {
        flip(false, false);
        map.forEach((row, y) => row.forEach((c, x) => {
          if (legend.has(c)) {
            const o = legend.get(c);
            draw(o.gfxnum, o.palnum, x * 8, y * 8);
          } else {
            ctx.clearRect(x * 8, y * 8, 8, 8);
          }
        }));
      } else if (code === "clear") { 
        ctx.clearRect(0, 0, 800, 600);
      } else if (code === "yield") {
          const myrun = () => module.ccall("run_lua", "number", ["string", "string"], [luaresume, 'return "ok"']);
          yieldTimer = setTimeout(myrun, 10);
      } else {
        console.error(`unkown code sent from Lua. code: "%o". payload: %o`, code, payload);
      }
    }
  };

  editor.value = filecontent;

  const prelude = `
  local send = webSend
  webSend = nil
  web = {
    send = send,
    require = function(name, path, filename)
      local loaded = package.loaded[name]
      if loaded then return loaded end
      filename = filename or (name .. ".lua")
      web.co = coroutine.running()
      send("require", path .. " " .. filename)
      local thunk = coroutine.yield()
      thunk()
      return require(name)
    end,
    run = function(thunk)
      coroutine.wrap(
        function()
          local _, res = pcall(thunk)
          if res ~= nil then send("return", tostring(res)) end
        end
      )()
    end,
    resume = function(thunk)
      local prev = web.co
      web.co = nil
      coroutine.resume(prev, thunk);
    end,
    defgfx = function(num, gfx)
      send("defgfx", num .. " " .. gfx)
    end,
    defpal = function(num, pal)
      send("defpal", num .. " " .. pal)
    end,
    legend = function(c, gi, pi)
      send("legend", c .. " " .. gi .. " " .. pi)
    end,
    row = function(str)
      send("row", str)
    end,
    yield = function()
      send("yield", "")
      web.co = coroutine.running()
      local thunk = coroutine.yield()
      thunk()
    end
  }
  local Web = {}
  setmetatable(web, Web)
  function Web:__index(code)
    return function(payload) send(code, payload) end
  end
  `;

  initWasmModule(config).then((m) => {
    module = m;
  
    module.ccall("run_lua", "number", ["string", "string"], [luaplain, prelude]);
    runLua();
    editor.oninput = () => {
      modified(500);
    };
    autorun.onchange = () => {
      if (!autorun.checked) {
        clearTimeout(timer);
      } else if (dirty) {
        runLua();
      }
    };
    run.onclick = runLua;
  });
};

window.onload = () => {
  const defaultcode = `web.defgfx(0, "00410455106610551554155415541004")
web.defgfx(1, "10004010400400040000004001000100");
web.defgfx(2, "65556555aaaa556555655565aaaa6555")
web.defpal(0, "11c5")
web.defpal(1, "eea5")
web.defpal(2, "3b14")
web.defpal(3, "0243")
web.legend(" ", 1, 2)
web.legend("#", 2, 3)


web.row("  #####    ")
web.row("  #   #####")
web.row("###       #")
web.row("#         #")
web.row("#####   ###")
web.row("    #   #  ")
web.row("    #####  ")

for x = 0, 12 do
  for y = 0, 12 do
    web.send("gfx", math.random(2, 31) .. " " .. math.random(0, 3) .. " " .. x * 8 .. " " .. y * 8)
  end
end

web.send("map")

web.send("gfx", "0 0 16 16")
web.send("gfx", "0 1 32 16 x")
`
  const file = new URLSearchParams(location.search).get("file");
  if (file !== null) {
    const xmlHttp = new XMLHttpRequest();
          xmlHttp.onreadystatechange = () => {
            if (xmlHttp.readyState === 4) {
              let code = "";
              if (xmlHttp.status === 200) {
                start(xmlHttp.response);
              } else {
                console.error(xmlHttp);
                start(defaultcode);
              }
            }
          };
          xmlHttp.open("GET", file, true);
          xmlHttp.send(null);
  } else {
    start(defaultcode);
  }
};

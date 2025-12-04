const fontsprites = [
  "00000000000000000000000000000000",
  "15544001441140014551414140011554",
  "15545555514555555005541555551554",
  "14505554555455541550054001000000",
  "01000540155055541550054001000000",
  "05401550054055545554511401000540",
  "01000100054015505554155001000540",
  "00000000014005500550014000000000",
  "55555555541550055005541555555555",
  "00000550141410041004141405500000",
  "55555005414145514551414150055555",
  "00550015005515515050505050501540",
  "05501414141414140550014015540140",
  "05550505055505000500150055005400",
  "15551405155514051405141554145000",
  "01405145055054155415055051450140",
  "40005400554055545540540040000000",
  "00040054055455540554005400040000",
  "01400550155401400140155405500140",
  "14141414141414141414000014140000",
  "15555145514515450145014501450000",
  "05541405054014501450054050501540",
  "00000000000000001554155415540000",
  "01400550155401401554055001405555",
  "01400550155401400140014001400000",
  "01400140014001401554055001400000",
  "00000140005055540050014000000000",
  "00000500140055541400050000000000",
  "00000000500050005000555400000000",
  "00000410141455551414041000000000",
  "00000140055015545555555500000000",
  "00005555555515540550014000000000",
  "00000000000000000000000000000000",
  "05001540154005000500000005000000",
  "14501450145000000000000000000000",
  "14501450555414505554145014500000",
  "05001550500015400050554005000000",
  "00005014505001400500141450140000",
  "05401450054015145150505015140000",
  "14001400500000000000000000000000",
  "01400500140014001400050001400000",
  "14000500014001400140050014000000",
  "00001414055055550550141400000000",
  "00000500050055500500050000000000",
  "00000000000000000000050005001400",
  "00000000000055500000000000000000",
  "00000000000000000000050005000000",
  "00140050014005001400500040000000",
  "15505014505451545514541415500000",
  "05001500050005000500050055500000",
  "15405050005005401400505055500000",
  "15405050005005400050505015400000",
  "01500550145050505554005001540000",
  "55505000554000500050505015400000",
  "05401400500055405050505015400000",
  "55505050005001400500050005000000",
  "15405050505015405050505015400000",
  "15405050505015500050014015000000",
  "00000500050000000000050005000000",
  "00000500050000000000050005001400",
  "01400500140050001400050001400000",
  "00000000555000000000555000000000",
  "14000500014000500140050014000000",
  "15405050005001400500000005000000",
  "15505014515451545154500015400000",
  "05001540505050505550505050500000",
  "55501414141415501414141455500000",
  "05501414500050005000141405500000",
  "55401450141414141414145055400000",
  "55541404144015401440140455540000",
  "55541404144015401440140055000000",
  "05501414500050005054141405540000",
  "50505050505055505050505050500000",
  "15400500050005000500050015400000",
  "01540050005000505050505015400000",
  "54141414145015401450141454140000",
  "55001400140014001404141455540000",
  "50145454555455545114501450140000",
  "50145414551451545054501450140000",
  "05401450501450145014145005400000",
  "55501414141415501400140055000000",
  "15405050505050505150154001500000",
  "55501414141415501450141454140000",
  "15405050140005000140505015400000",
  "55504510050005000500050015400000",
  "50505050505050505050505055500000",
  "50505050505050505050154005000000",
  "50145014501451145554545450140000",
  "50145014145005400540145050140000",
  "50505050505015400500050015400000",
  "55545014405001400504141455540000",
  "15401400140014001400140015400000",
  "50001400050001400050001400040000",
  "15400140014001400140014015400000",
  "01000540145050140000000000000000",
  "00000000000000000000000000005555",
  "05000500014000000000000000000000",
  "00000000154000501550505015140000",
  "54001400140015501414141451500000",
  "00000000154050505000505015400000",
  "01500050005015505050505015140000",
  "00000000154050505550500015400000",
  "05401450140055001400140055000000",
  "00000000151450505050155000505540",
  "54001400145015141414141454140000",
  "05000000150005000500050015400000",
  "00500000005000500050505050501540",
  "54001400141414501540145054140000",
  "15000500050005000500050015400000",
  "00000000505055545554511450140000",
  "00000000554050505050505050500000",
  "00000000154050505050505015400000",
  "00000000515014141414155014005500",
  "00000000151450505050155000500154",
  "00000000515015141414140055000000",
  "00000000155050001540005055400000",
  "01000500155005000500051001400000",
  "00000000505050505050505015140000",
  "00000000505050505050154005000000",
  "00000000501451145554555414500000",
  "00000000501414500540145050140000",
  "00000000505050505050155000505540",
  "00000000555041400500141055500000",
  "01500500050054000500050001500000",
  "01400140014000000140014001400000",
  "54000500050001500500050054000000",
  "15145150000000000000000000000000",
  "00000100054014505014501455540000",
  "15405050500050501540014000501540",
  "00005050000050505050505015540000",
  "01500000154050505550500015400000",
  "15545005055000140554141405550000",
  "50500000154000501550505015540000",
  "54000000154000501550505015540000",
  "05000500154000501550505015540000",
  "00000000154050005000154000500540",
  "15545005055014141554140005500000",
  "50500000154050505550500015400000",
  "54000000154050505550500015400000",
  "50500000150005000500050015400000",
  "15505014054001400140014005500000",
  "54000000150005000500050015400000",
  "50140540145050145554501450140000",
  "05000500000015405050555050500000",
  "01500000555014001540140055500000",
  "00000000155500501555505015550000",
  "05541450505055545050505050540000",
  "15405050000015405050505015400000",
  "00005050000015405050505015400000",
  "00005400000015405050505015400000",
  "15405050000050505050505015540000",
  "00005400000050505050505015540000",
  "00005050000050505050155000505540",
  "50050140055014141414055001400000",
  "50500000505050505050505015400000",
  "01400140155450005000155401400140",
  "05401450141055001400541455500000",
  "50505050154055500500555005000500",
  "55405050505055445014505550145015",
  "00540145014005500140014051401500",
  "01500000154000501550505015540000",
  "05400000150005000500050015400000",
  "00000150000015405050505015400000",
  "00000150000050505050505015540000",
  "00005540000055405050505050500000",
  "55500000505054505550515050500000",
  "05501450145005540000155400000000",
  "05401450145005400000155000000000",
  "05000000050014005000505015400000",
  "00000000000055505000500000000000",
  "00000000000055500050005000000000",
  "50055014505051540505141450500055",
  "50055014505051450515145550550005",
  "01400140000001400140014001400000",
  "00000505141450501414050500000000",
  "00005050141405051414505000000000",
  "04044040040440400404404004044040",
  "11114444111144441111444411114444",
  "51451515514554545145151551455454",
  "01400140014001400140014001400140",
  "01400140014001405540014001400140",
  "01400140554001405540014001400140",
  "05140514051405145514051405140514",
  "00000000000000005554051405140514",
  "00000000554001405540014001400140",
  "05140514551400145514051405140514",
  "05140514051405140514051405140514",
  "00000000555400145514051405140514",
  "05140514551400145554000000000000",
  "05140514051405145554000000000000",
  "01400140554001405540000000000000",
  "00000000000000005540014001400140",
  "01400140014001400155000000000000",
  "01400140014001405555000000000000",
  "00000000000000005555014001400140",
  "01400140014001400155014001400140",
  "00000000000000005555000000000000",
  "01400140014001405555014001400140",
  "01400140015501400155014001400140",
  "05140514051405140515051405140514",
  "05140514051505000555000000000000",
  "00000000055505000515051405140514",
  "05140514551500005555000000000000",
  "00000000555500005515051405140514",
  "05140514051505000515051405140514",
  "00000000555500005555000000000000",
  "05140514551500005515051405140514",
  "01400140555500005555000000000000",
  "05140514051405145555000000000000",
  "00000000555500005555014001400140",
  "00000000000000005555051405140514",
  "05140514051405140555000000000000",
  "01400140015501400155000000000000",
  "00000000015501400155014001400140",
  "00000000000000000555051405140514",
  "05140514051405145555051405140514",
  "01400140555501405555014001400140",
  "01400140014001405540000000000000",
  "00000000000000000155014001400140",
  "55555555555555555555555555555555",
  "00000000000000005555555555555555",
  "55005500550055005500550055005500",
  "00550055005500550055005500550055",
  "55555555555555550000000000000000",
  "00000000151451505040515015140000",
  "00001540505055405050554050005000",
  "00005550505050005000500050000000",
  "00005554145014501450145014500000",
  "55505050140005001400505055500000",
  "00000000155451405140514015000000",
  "00001414141414141414155014005000",
  "00001514515001400140014001400000",
  "55500500154050505050154005005550",
  "05401450501455545014145005400000",
  "05401450501450141450145054540000",
  "01500500014015505050505015400000",
  "00000000155451455145155400000000",
  "00140050155451455145155414005000",
  "05401400500055405000140005400000",
  "15405050505050505050505050500000",
  "00005550000055500000555000000000",
  "05000500555005000500000055500000",
  "14000500014005001400000055500000",
  "01400500140005000140000055500000",
  "00540145014501400140014001400140",
  "01400140014001400140514051401500",
  "05000500000055500000050005000000",
  "00001514515000001514515000000000",
  "05401450145005400000000000000000",
  "00000000000001400140000000000000",
  "00000000000000000140000000000000",
  "00550050005000505450145005500150",
  "15401450145014501450000000000000",
  "15000140050014001540000000000000",
  "00000000055005500550055000000000",
  "00000000000000000000000000000000"
];

const fontpals = ["0000", "8888", "7777", "7000"];

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
const fontcanvas = new OffscreenCanvas(256, 256);
const fontctx = fontcanvas.getContext("2d");
fontcanvas.imageSmoothingEnabled = false;
fontctx.imageSmoothingEnabled = false;

const drawgfx = (ctx, dx, dy, sprhex, palhex) => {
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

const palpos = i => {
  if (i === 0) return { x: 0, y: 0 };
  if (i === 1) return { x: 128, y: 0 };
  if (i === 2) return { x: 0, y: 128 };
  if (i === 3) return { x: 128, y: 128 };
  throw(`palpos(${i})`);
};

const rendersheetpal = (sheet, pal, ctx, start) => {
  let i = 0;
  for (let y = 0; y < 16; y++) {
    for (let x = 0; x < 16; x++) {
      drawgfx(ctx, start.x + (x * 8), start.y + (y * 8), sheet[i], pal);
      i++;
    }
  }
};

const rendersheet = (sheet, pals, ctx) => {
  ctx.clearRect(0, 0, 256, 256);
  for (let i = 0; i < 4; i++) {
    rendersheetpal(sheet, pals[i], ctx, palpos(i));
  }
};

const offrender = () => {
  if (offready) {
    return;
  }
  rendersheet(sprites, pals, offctx);
  rendersheet(fontsprites, fontpals, fontctx);
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

const draw = (canvas, s, p, x, y) => {
  const f = (i, b) => b ? -i - 8 : i;
  const ppos = palpos(p);
  const col = s % 16;
  const row = Math.trunc(s / 16);
  ctx.drawImage(canvas, ppos.x + (col * 8), ppos.y + (row * 8), 8, 8, f(x, flipx), f(y, flipy), 8, 8);
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
    sprites = array(256, rhex(32));
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
        draw(offcanvas, parseInt(par[0]), parseInt(par[1]), parseInt(par[2]), parseInt(par[3]));
      } else if (code === "letter") {
        offrender();
        flip(false, false);
        const par = params(payload);
        draw(fontcanvas, parseInt(par[0]), parseInt(par[1]), parseInt(par[2]), parseInt(par[3]));
      } else if (code === "legend") {
        const p = params(payload.substring(1));
        legend.set(payload[0], { gfxnum: parseInt(p[0]), palnum: parseInt(p[1]) });
      } else if (code === "newmap") {
        map = [];
      } else if (code === "row") {
        map.push(payload.split(""));
      } else if (code === "mapset") {
        const par = params(payload);
        const x = parseInt(par[0]);
        const y = parseInt(par[1]);
        const c = par[2];
        if (y < map.length && x < map[y].length) {
          map[y][x] = c;
        }
      } else if (code === "map") {
        offrender();
        flip(false, false);
        map.forEach((row, y) => row.forEach((c, x) => {
          if (legend.has(c)) {
            const o = legend.get(c);
            draw(offcanvas, o.gfxnum, o.palnum, x * 8, y * 8);
          } else {
            ctx.clearRect(x * 8, y * 8, 8, 8);
          }
        }));
      } else if (code === "clear") { 
        ctx.fillStyle = fullpal[parseInt(params(payload)[0])]
        ctx.fillRect(0, 0, 800, 600);
      } else if (code === "yield") {
          const myrun = () => {
             console.log("resuming");
             module.ccall("run_lua", "number", ["string", "string"], [luaresume, 'return "ok"']);
           }
          yieldTimer = setTimeout(myrun, parseInt(params(payload)[0]));
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
    gfx = function(num, pal, x, y, flip)
      send("gfx", num .. " " .. pal .. " " .. x .. " " .. y .. " " .. (flip or ""))
    end,
    clear = function(colornum)
      send("clear", tostring(colornum or 7))
    end,
    legend = function(c, gi, pi)
      send("legend", c .. " " .. gi .. " " .. pi)
    end,
    row = function(str)
      send("row", str)
    end,
    mapset = function(x, y, c)
      web.send("mapset", x .. " " .. y .. " " .. c)
    end,
    string = function(str, pal, x, y, ltr)
      str = tostring(str)
      local moveby
      if ltr then
        moveby = -8
        x = x - 8
        str = str:reverse()
      else moveby = 8
      end
      for c in str:gmatch(".") do
        send("letter", string.byte(c) .. " " .. pal .. " " .. x .. " " .. y)
        x = x + moveby
      end
    end,
    yield = function(n)
      send("yield", tostring(n))
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
web.defgfx(1, "10004010400400040000004001000100")
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
    web.send("gfx", math.random(2, 255) .. " " .. math.random(0, 3) .. " " .. x * 8 .. " " .. y * 8)
  end
end

web.send("map")

web.gfx(0, 0, 32, 24)
web.gfx(0, 1, 48, 24, "x")
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

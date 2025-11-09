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
    result.replaceChildren(elem("pre", { className: "output" }));
    const str = editor.value;
    module.ccall("run_lua", "number", ["string", "string"], [luarun, str]);
  };

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
  const defaultcode = `print(("hello"):rep(5))
print("world")
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

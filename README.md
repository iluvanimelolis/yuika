### Supported Games
* [✔] [**Da Hood**](https://www.roblox.com/games/2788229376/Da-Hood) (UpdateMousePos)
* [✔] [**Hood Modded**](https://www.roblox.com/games/5602055394/Hood-Modded) (MousePos)
* [✔] [**Untitled Hood**](https://www.roblox.com/games/9183932460/Untitled-Hood) (UpdateMousePos)
* [✔] [**Da Hood Aim Trainer**](https://www.roblox.com/games/9824221333/UPDATE-Da-Hood-Aim-Trainer) (UpdateMousePos)

### Supported Executors
* [❌] [Krnl](https://krnl.place/) (Not Tested)
* [✔] [Synapse X](https://x.synapse.to/) ($20 USD)

### Script Loadstring
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/ketaminee/yuika/main/source.lua"))()

getgenv().Settings = {
    Key = "Q"; -- Target Key
    AAKey = "Z"; -- Anti Aim Key
    Target = nil; -- Current Target
    AAEnabled = false; -- Anti Aim Enabled
    Prediction = 0.135; -- Aimlock Prediction
    Part = "HumanoidRootPart"; -- Hit Part
}
```

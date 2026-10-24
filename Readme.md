# Windows Rice & Dotfiles 🪟⚡

A fully automated setup script and configuration bundle to replicate my personal Windows tiling and aesthetic environment (Komorebi, YASB, Rainmeter, Fastfetch, and custom PowerShell profile) on any machine.

---

## Included Components

* **Tiling Window Manager:** [Komorebi](https://github.com/LGUG2Z/komorebi) + [whkd](https://github.com/LGUG2Z/whkd) for hotkeys.
* **Status Bar:** [YASB](https://github.com/amnweb/yasb) with custom CSS styling.
* **Terminal Dashboard:** [Fastfetch](https://github.com/fastfetch-cli/fastfetch) paired with a customized, portable PowerShell profile.
* **Desktop Widgets & Overlays:** [Rainmeter](https://www.rainmeter.net/) skins (including JaxCore framework, Vault, and custom visualizers).
* **System Tweaks:** [Windhawk](https://windhawk.net/) custom mods and registry configurations.
* **Typography:** JetBrains Mono and custom local font assets.

---

## How to Run & Install

To deploy this entire setup onto a fresh Windows machine, follow these steps:

### 1. Clone the Repository
Open PowerShell and clone your dotfiles repository:
```powershell
git clone https://github.com/YourUsername/dotfiles.git
cd dotfiles
```

### 2. Run the Installer
Open **PowerShell as Administrator** (right-click PowerShell -> *Run as administrator*), navigate to your cloned dotfiles directory, and execute the installation script:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install.ps1
```

### 3. What the Script Does Automatically:
1. Installs core apps and font packages (`Komorebi`, `whkd`, `YASB`, `Fastfetch`, `Rainmeter`, `Windhawk`, `JetBrains Mono`) via Winget.
2. Registers any extra custom local fonts from your `fonts/` folder into the Windows font directory.
3. Deploys your portable PowerShell profile and Fastfetch configuration.
4. Places window manager and status bar configs in their proper AppData directories.
5. Moves custom Rainmeter skin folders directly into `Documents\Rainmeter\Skins\`.
6. Restores Windhawk mod files and imports registry settings.

---

## Credits & Acknowledgments

Huge thanks to the open-source creators and maintainers whose tools make this Windows desktop setup possible:

* **[LGUG2Z](https://github.com/LGUG2Z)** for creating **[Komorebi](https://github.com/LGUG2Z/komorebi)** and **[whkd](https://github.com/LGUG2Z/whkd)**.
* **[amnweb](https://github.com/amnweb)** for the **[YASB](https://github.com/amnweb/yasb)** status bar.
* **[Rainmeter Team](https://www.rainmeter.net/)** and **[JaxCore](https://github.com/Jax-Core)** for desktop widget customization.
* **[RamenSoftware](https://windhawk.net/)** for **[Windhawk](https://windhawk.net/)** Windows customization engine.
* **[Fastfetch CLI](https://github.com/fastfetch-cli/fastfetch)** for fast system information display.
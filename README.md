# Omalauncher Tesla tile

Read-only Tesla status for an [Omalauncher](https://github.com/SimonSchubert/omalauncher) home screen. Battery, range, lock, climate, tires, and charge limit. It never wakes the car.

This repository is the backup of the tile and its helpers. It does not contain a Tesla token, a VIN, or a car name. Those stay on the phone, in `~/.config/omarchy-tesla/` (mode 600) and the launcher's own saved state.

## Reinstall

From a checkout of this repo, on the phone:

```bash
./install.sh
```

That copies:

- `widget.owl` to `~/.config/omalauncher/widgets/30-tesla.owl`
- `bin/tesla-status`, `bin/tesla-auth-open`, and `bin/tesla-auth-setup` to `~/.local/bin/`

`install.sh` does not read, replace, or delete a refresh token. Packages the tile expects are `curl`, `jq`, and `openssl`.

The file asks for page 2, which is where this phone keeps it. The launcher only uses that the first time the tile is added. A tile that is already placed stays where you put it.

## Sign in

Open the tile. The signed-out screen is the guide.

1. On a computer, download [Tesla Auth](https://github.com/adriankumpf/tesla_auth/releases/latest), run it, and sign in on Tesla's own page. Copy the **refresh token**, not the access token.
2. Or on this phone, run the optional helper. It is separate from the tile. It installs Tesla Auth for aarch64 only if it is missing, then opens the same login:

   ```bash
   tesla-auth-setup
   ```

   The phone login needs `webkit2gtk-4.1` and `xdotool`. Do not pass `--debug` to Tesla Auth. That flag can print URLs that include the sign-in code.
3. Paste the refresh token with `tesla-status token`, or use the tile's paste button.

You type your own password and MFA. The token is the whole Tesla account. The tile only reads the car. A parked car is left alone for 15 minutes, and nothing here calls `wake_up`.

If the car is asleep, the first numbers wait until it is already awake on its own.

## What is not in here

- The refresh token and the access token.
- Cached car readings.
- A screenshot of the live tile. Those show the car's name and mileage.
- The Tesla Auth program itself. The phone helper downloads the upstream aarch64 release when you run it.

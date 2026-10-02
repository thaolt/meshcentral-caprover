# meshcentral-caprover

Deploy [MeshCentral](https://meshcentral.com) - a self-hosted remote device
management server - on [CapRover](https://caprover.com) with a single
`caprover deploy`.

## How it works

- `Dockerfile` installs `meshcentral` at build time into `/app` via `npm ci`.
- `start.sh` launches the server with `--wanonly --tlsoffload`, so MeshCentral
  serves plain HTTP on port `443` and CapRover's nginx terminates TLS
  (Let's Encrypt) in front of it.
- MeshCentral resolves its state directories (`meshcentral-data`,
  `meshcentral-files`, `meshcentral-backups`, `meshcentral-recordings`)
  relative to its module location - the parent of `node_modules`, i.e. `/app`.
  The Dockerfile symlinks those directories into `/meshcenter` so all state
  lands on a persistent volume.

## Deploy

1. Create a new app in CapRover (e.g. `meshcenter`).
2. In the app's **App Configs**, set:
   - **Container HTTP Port**: `443`
   - **HTTPS**: enabled (CapRover issues the cert; the container speaks HTTP)
   - **Persistent directory**: host path of your choice mapped to `/meshcenter`
3. Deploy:

   ```sh
   caprover deploy
   ```

4. Open `https://<your-app>.<caprover-domain>` and create the admin account.

## Layout after first boot

```
/meshcenter/                    # persistent volume
├── meshcentral-data/           # config.json, certs, NeDB database
├── meshcentral-files/          # files uploaded to devices
├── meshcentral-backups/        # autobackup output
└── meshcentral-recordings/     # session recordings
```

`/app` inside the image holds `node_modules` and the read-only application -
nothing in it needs to persist.

## License

MIT

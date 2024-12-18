# (cargo install --git https://github.com/bram209/leptosfmt.git)

setup-ml:
	(pip install -e ./infrastructure/ml/transformers/tts)

setup: setup-ml
	(cargo install --locked cargo-make cargo-expand cargo-tree)
	(cargo install cargo-leptos leptosfmt)
	(cargo install tauri-cli --version "^2.0.0-rc")
	(cargo install dioxus-cli)
	(cargo install --locked cargo-xwin)

vendor:
	(cargo vendor .cache/cargo)

fmt:
	(rustfmt ./src/**/*.rs)
	(leptosfmt ./src)

build-framework:
	(cd ./services/platform && cargo make framework_build)

dev-commlink_overlay:
	(cd ./apps/commlink_overlay && cargo tauri dev)

dev: build-framework
	(cd ./services/platform && cargo make devserver)

build-commlink_overlay:
	(cd ./apps/commlink_overlay && cargo tauri build)
# (rustup target add aarch64-pc-windows-msvc)
# (cd ./apps/commlink_overlay && cargo tauri build --target aarch64-pc-windows-msvc --bundles nsis)

build:
	(cargo leptos build --release)

# preview:
#	()

deploy:
	(sudo mkdir -p /akaia/configuration/web-server)
	(sudo cp --update system/configuration/web-server/* /akaia/configuration/web-server/)
	(sudo cp --update .target/linux-unknown-unknown/etc/systemd/system/* /etc/systemd/system/)
	(sudo chown -R akaia:akaia /akaia/configuration)
	(sudo systemctl daemon-reload)
	(sudo systemctl enable web-server)
	(sudo systemctl restart web-server)

say:
	(./target/aarch64-linux-gnu/bin/say.sh)

#!/bin/sh

################################################################################
#
#  install-source
#  Libraries to support *-install scripts
#
#  MIT License.
#  Copyright (C) 2025 Nguyen Nhat Tung.
#
################################################################################

set +x

# ------------------------------------------------------------------------------
# Return the GitHub owner for a Program ID.
# ------------------------------------------------------------------------------
get_source_owner() {
	case "$1" in
		7z) echo "ip7z" ;;
		agave) echo "anza-xyz" ;;
		bifrost-http) echo "maximhq" ;;
		bsc-erigon) echo "node-real" ;;
		bsc-geth) echo "bnb-chain" ;;
		bsc-reth) echo "bnb-chain" ;;
		btop) echo "aristocratos" ;;
		bun) echo "oven-sh" ;;
		composer) echo "composer" ;;
		doublecmd) echo "doublecmd" ;;
		erigon) echo "erigontech" ;;
		firefox) echo "" ;;
		foundry) echo "foundry-rs" ;;
		geth) echo "ethereum" ;;
		gitea) echo "go-gitea" ;;
		go) echo "" ;;
		golangci-lint) echo "golangci" ;;
		grafana-alloy) echo "grafana" ;;
		grafana-loki) echo "grafana" ;;
		hugo) echo "gohugoio" ;;
		jellyfin) echo "" ;;
		just) echo "casey" ;;
		nvm) echo "nvm-sh" ;;
		ollama) echo "ollama" ;;
		op-reth) echo "paradigmxyz" ;;
		op-node) echo "ethereum-optimism" ;;
		opencode) echo "anomalyco" ;;
		opencode-desktop) echo "anomalyco" ;;
		pgweb) echo "sosedoff" ;;
		pnpm) echo "pnpm" ;;
		prometheus) echo "prometheus" ;;
		prysm) echo "OffchainLabs" ;;
		qdrant) echo "qdrant" ;;
		reth) echo "paradigmxyz" ;;
		rust) echo "rust-lang" ;;
		sass) echo "sass" ;;
		snitch) echo "karol-broda" ;;
		solana) echo "solana-labs" ;;
		stashapp) echo "stashapp" ;;
		stashbox) echo "stashapp" ;;
		sui) echo "MystenLabs" ;;
		syncthing) echo "syncthing" ;;
		syncthrelay) echo "syncthing" ;;
		syncthdiscv) echo "syncthing" ;;
		tabby) echo "Eugeny" ;;
		telegram) echo "telegramdesktop" ;;
		thunderbird) echo "" ;;
		tufw) echo "peltho" ;;
		uv) echo "astral-sh" ;;
		viction) echo "BuildOnViction" ;;
		vscode) echo "microsoft" ;;
		waterfox) echo "BrowserWorks" ;;
		yellowstone-grpc) echo "rpcpool" ;;
		ytdlp) echo "yt-dlp" ;;
		zenith) echo "bvaisvil" ;;
		*) echo "" ;;
	esac
}

# ------------------------------------------------------------------------------
# Return the GitHub repository for a Program ID.
# ------------------------------------------------------------------------------
get_source_repo() {
	case "$1" in
		7z) echo "7zip" ;;
		agave) echo "agave" ;;
		bifrost-http) echo "bifrost" ;;
		bsc-erigon) echo "bsc-erigon" ;;
		bsc-geth) echo "bsc" ;;
		bsc-reth) echo "reth-bsc" ;;
		btop) echo "btop" ;;
		bun) echo "bun" ;;
		composer) echo "composer" ;;
		doublecmd) echo "doublecmd" ;;
		erigon) echo "erigon" ;;
		firefox) echo "" ;;
		foundry) echo "foundry" ;;
		geth) echo "go-ethereum" ;;
		gitea) echo "gitea" ;;
		go) echo "" ;;
		golangci-lint) echo "golangci-lint" ;;
		grafana-alloy) echo "alloy" ;;
		grafana-loki) echo "loki" ;;
		hugo) echo "hugo" ;;
		jellyfin) echo "" ;;
		just) echo "just" ;;
		nvm) echo "nvm" ;;
		ollama) echo "ollama" ;;
		op-reth) echo "reth" ;;
		op-node) echo "optimism" ;;
		opencode) echo "opencode" ;;
		opencode-desktop) echo "opencode" ;;
		pgweb) echo "pgweb" ;;
		pnpm) echo "pnpm" ;;
		prometheus) echo "prometheus" ;;
		prysm) echo "prysm" ;;
		qdrant) echo "qdrant" ;;
		reth) echo "reth" ;;
		rust) echo "rust" ;;
		sass) echo "dart-sass" ;;
		snitch) echo "snitch" ;;
		solana) echo "solana" ;;
		stashapp) echo "stash" ;;
		stashbox) echo "stash-box" ;;
		sui) echo "sui" ;;
		syncthing) echo "syncthing" ;;
		syncthrelay) echo "relaysrv" ;;
		syncthdiscv) echo "discosrv" ;;
		tabby) echo "tabby" ;;
		telegram) echo "tdesktop" ;;
		thunderbird) echo "" ;;
		tufw) echo "tufw" ;;
		uv) echo "uv" ;;
		viction) echo "victionchain" ;;
		vscode) echo "vscode" ;;
		waterfox) echo "waterfox" ;;
		yellowstone-grpc) echo "yellowstone-grpc" ;;
		ytdlp) echo "yt-dlp" ;;
		zenith) echo "zenith" ;;
		*) echo "" ;;
	esac
}

# ------------------------------------------------------------------------------
# Return the download URI for AMD64 for a Program ID.
# ------------------------------------------------------------------------------
get_download_uri_amd64() {
	case "$1" in
		7z)
			_v_nodot=$(echo "$2" | sed 's/\.//g')
			echo "https://github.com/ip7z/7zip/releases/download/${2}/7z${_v_nodot}-linux-x64.tar.xz" ;;
		agave)
			echo "https://github.com/anza-xyz/agave/archive/refs/tags/v${2}.tar.gz" ;;
		bifrost-http)
			echo "https://downloads.getmaxim.ai/bifrost/v${2}/linux/amd64/bifrost-http" ;;
		bsc-erigon)
			echo "https://github.com/node-real/bsc-erigon/releases/download/v${2}/bsc-erigon_v${2}_linux_amd64v2.tar.gz" ;;
		bsc-geth)
			echo "https://github.com/bnb-chain/bsc/releases/download/v${2}/geth_linux" ;;
		bsc-reth)
			echo "https://github.com/bnb-chain/reth-bsc/archive/refs/tags/v${2}.tar.gz" ;;
		btop)
			echo "https://github.com/aristocratos/btop/releases/download/v${2}/btop-x86_64-unknown-linux-musl.tar.gz" ;;
		bun)
			echo "https://github.com/oven-sh/bun/releases/download/bun-v${2}/bun-linux-x64.zip" ;;
		composer)
			echo "https://github.com/composer/composer/releases/download/${2}/composer.phar" ;;
		doublecmd)
			echo "https://github.com/doublecmd/doublecmd/releases/download/v${2}/doublecmd-${2}.qt.x86_64.tar.xz" ;;
		erigon)
			echo "https://github.com/erigontech/erigon/releases/download/v${2}/erigon_v${2}_linux_amd64v2.tar.gz" ;;
		firefox)
			echo "https://ftp.mozilla.org/pub/firefox/releases/${2}/linux-x86_64/en-US/firefox-${2}.tar.xz" ;;
		foundry)
			echo "https://github.com/foundry-rs/foundry/releases/download/v${2}/foundry_v${2}_linux_amd64.tar.gz" ;;
		geth)
			echo "https://github.com/ethereum/go-ethereum/archive/refs/tags/v${2}.tar.gz" ;;
		gitea)
			echo "https://github.com/go-gitea/gitea/releases/download/v${2}/gitea-${2}-linux-amd64" ;;
		go)
			echo "https://go.dev/dl/go${2}.linux-amd64.tar.gz" ;;
		golangci-lint)
			echo "https://github.com/golangci/golangci-lint/releases/download/v${2}/golangci-lint-${2}-linux-amd64.tar.gz" ;;
		grafana-alloy)
			echo "https://github.com/grafana/alloy/releases/download/v${2}/alloy-linux-amd64.zip" ;;
		grafana-loki)
			echo "https://github.com/grafana/loki/releases/download/v${2}/loki-linux-amd64.zip" ;;
		hugo)
			echo "https://github.com/gohugoio/hugo/releases/download/v${2}/hugo_extended_withdeploy_${2}_linux-amd64.tar.gz" ;;
		jellyfin)
			echo "https://repo.jellyfin.org/files/server/linux/stable/v${2}/amd64/jellyfin_${2}-amd64.tar.xz" ;;
		just)
			echo "https://github.com/casey/just/releases/download/${2}/just-${2}-x86_64-unknown-linux-musl.tar.gz" ;;
		ollama)
			echo "https://github.com/ollama/ollama/releases/download/v${2}/ollama-linux-amd64.tar.zst" ;;
		op-reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${2}/op-reth-v${2}-x86_64-unknown-linux-gnu.tar.gz" ;;
		op-node)
			echo "https://github.com/ethereum-optimism/optimism/archive/refs/tags/v${2}.tar.gz" ;;
		opencode)
			echo "https://github.com/anomalyco/opencode/releases/download/v${2}/opencode-linux-x64.tar.gz" ;;
		opencode-desktop)
			echo "https://github.com/anomalyco/opencode/releases/download/v${2}/opencode-desktop-linux-x86_64.AppImage" ;;
		pgweb)
			echo "https://github.com/sosedoff/pgweb/releases/download/v${2}/pgweb_linux_amd64.zip" ;;
		pnpm)
			echo "https://github.com/pnpm/pnpm/releases/download/v${2}/pnpm-linux-x64" ;;
		prometheus)
			echo "https://github.com/prometheus/prometheus/releases/download/v${2}/prometheus-${2}.linux-amd64.tar.gz" ;;
		prysm-beacon)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${2}/beacon-chain-v${2}-modern-linux-amd64" ;;
		prysm-stats)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${2}/client-stats-v${2}-linux-amd64" ;;
		prysmctl)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${2}/prysmctl-v${2}-linux-amd64" ;;
		qdrant)
			echo "https://github.com/qdrant/qdrant/releases/download/v${2}/qdrant-x86_64-unknown-linux-musl.tar.gz" ;;
		reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${2}/reth-v${2}-x86_64-unknown-linux-gnu.tar.gz" ;;
		sass)
			echo "https://github.com/sass/dart-sass/releases/download/${2}/dart-sass-${2}-linux-x64.tar.gz" ;;
		snitch)
			echo "https://github.com/karol-broda/snitch/releases/download/v${2}/snitch_${2}_linux_amd64.tar.gz" ;;
		solana)
			echo "https://github.com/solana-labs/solana/releases/download/v${2}/solana-release-x86_64-unknown-linux-gnu.tar.bz2" ;;
		stashapp)
			echo "https://github.com/stashapp/stash/releases/download/v${2}/stash-linux" ;;
		stashbox)
			echo "https://github.com/stashapp/stash-box/releases/download/v${2}/stash-box-linux" ;;
		sui)
			echo "https://github.com/MystenLabs/sui/releases/download/mainnet-v${2}/sui-mainnet-v${2}-ubuntu-x86_64.tgz" ;;
		syncthing)
			echo "https://github.com/syncthing/syncthing/releases/download/v${2}/syncthing-linux-amd64-v${2}.tar.gz" ;;
		syncthrelay)
			echo "https://github.com/syncthing/relaysrv/releases/download/v${2}/strelaysrv-linux-amd64-v${2}.tar.gz" ;;
		syncthdiscv)
			echo "https://github.com/syncthing/discosrv/releases/download/v${2}/stdiscosrv-linux-amd64-v${2}.tar.gz" ;;
		tabby)
			echo "https://github.com/Eugeny/tabby/releases/download/v${2}/tabby-${2}-linux-x64.tar.gz" ;;
		telegram)
			echo "https://github.com/telegramdesktop/tdesktop/releases/download/v${2}/tsetup.${2}.tar.xz" ;;
		thunderbird)
			echo "https://ftp.mozilla.org/pub/thunderbird/releases/${2}/linux-x86_64/en-US/thunderbird-${2}.tar.xz" ;;
		tufw)
			echo "https://github.com/peltho/tufw/releases/download/v${2}/tufw_${2}_linux_amd64.tar.gz" ;;
		uv)
			echo "https://github.com/astral-sh/uv/releases/download/${2}/uv-x86_64-unknown-linux-gnu.tar.gz" ;;
		viction)
			echo "https://github.com/BuildOnViction/victionchain/archive/refs/tags/v${2}.tar.gz" ;;
		vscode)
			echo "https://update.code.visualstudio.com/${2}/linux-x64/stable" ;;
		waterfox)
			echo "https://cdn.waterfox.com/waterfox/releases/${2}/Linux_x86_64/waterfox-${2}.tar.bz2" ;;
		yellowstone-grpc)
			echo "" ;;
		ytdlp)
			echo "https://github.com/yt-dlp/yt-dlp/releases/download/${2}/yt-dlp_linux" ;;
		zenith)
			echo "https://github.com/bvaisvil/zenith/releases/download/${2}/zenith-Linux-musl-x86_64.tar.gz" ;;
		*) echo "" ;;
	esac
}

# ------------------------------------------------------------------------------
# Return the download URI for ARM64 for a Program ID.
# ------------------------------------------------------------------------------
get_download_uri_arm64() {
	case "$1" in
		7z)
			_v_nodot=$(echo "$2" | sed 's/\.//g')
			echo "https://github.com/ip7z/7zip/releases/download/${2}/7z${_v_nodot}-linux-arm64.tar.xz" ;;
		agave)
			echo "https://github.com/anza-xyz/agave/archive/refs/tags/v${2}.tar.gz" ;;
		bifrost-http)
			echo "https://downloads.getmaxim.ai/bifrost/v${2}/linux/arm64/bifrost-http" ;;
		bsc-erigon)
			echo "https://github.com/node-real/bsc-erigon/releases/download/v${2}/bsc-erigon_v${2}_linux_arm64.tar.gz" ;;
		bsc-geth)
			echo "https://github.com/bnb-chain/bsc/releases/download/v${2}/geth-linux-arm64" ;;
		bsc-reth)
			echo "https://github.com/bnb-chain/reth-bsc/archive/refs/tags/v${2}.tar.gz" ;;
		btop)
			echo "https://github.com/aristocratos/btop/releases/download/v${2}/btop-aarch64-unknown-linux-musl.tar.gz" ;;
		bun)
			echo "https://github.com/oven-sh/bun/releases/download/bun-v${2}/bun-linux-aarch64.zip" ;;
		composer)
			echo "https://github.com/composer/composer/releases/download/${2}/composer.phar" ;;
		doublecmd)
			echo "https://github.com/doublecmd/doublecmd/releases/download/v${2}/doublecmd-${2}.qt.aarch64.tar.xz" ;;
		erigon)
			echo "https://github.com/erigontech/erigon/releases/download/v${2}/erigon_v${2}_linux_arm64.tar.gz" ;;
		firefox)
			echo "https://ftp.mozilla.org/pub/firefox/releases/${2}/linux-aarch64/en-US/firefox-${2}.tar.xz" ;;
		foundry)
			echo "https://github.com/foundry-rs/foundry/releases/download/v${2}/foundry_v${2}_linux_arm64.tar.gz" ;;
		geth)
			echo "https://github.com/ethereum/go-ethereum/archive/refs/tags/v${2}.tar.gz" ;;
		gitea)
			echo "https://github.com/go-gitea/gitea/releases/download/v${2}/gitea-${2}-linux-arm64" ;;
		go)
			echo "https://go.dev/dl/go${2}.linux-arm64.tar.gz" ;;
		golangci-lint)
			echo "https://github.com/golangci/golangci-lint/releases/download/v${2}/golangci-lint-${2}-linux-arm64.tar.gz" ;;
		hugo)
			echo "https://github.com/gohugoio/hugo/releases/download/v${2}/hugo_extended_withdeploy_${2}_linux-arm64.tar.gz" ;;
		grafana-alloy)
			echo "https://github.com/grafana/alloy/releases/download/v${2}/alloy-linux-arm64.zip" ;;
		grafana-loki)
			echo "https://github.com/grafana/loki/releases/download/v${2}/loki-linux-arm64.zip" ;;
		jellyfin)
			echo "https://repo.jellyfin.org/files/server/linux/stable/v${2}/arm64/jellyfin_${2}-arm64.tar.xz" ;;
		just)
			echo "https://github.com/casey/just/releases/download/${2}/just-${2}-aarch64-unknown-linux-musl.tar.gz" ;;
		ollama)
			echo "https://github.com/ollama/ollama/releases/download/v${2}/ollama-linux-arm64.tar.zst" ;;
		op-reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${2}/op-reth-v${2}-aarch64-unknown-linux-gnu.tar.gz" ;;
		op-node)
			echo "https://github.com/ethereum-optimism/optimism/archive/refs/tags/v${2}.tar.gz" ;;
		opencode)
			echo "https://github.com/anomalyco/opencode/releases/download/v${2}/opencode-linux-arm64.tar.gz" ;;
		opencode-desktop)
			echo "https://github.com/anomalyco/opencode/releases/download/v${2}/opencode-desktop-linux-arm64.AppImage" ;;
		pgweb)
			echo "https://github.com/sosedoff/pgweb/releases/download/v${2}/pgweb_linux_arm64.zip" ;;
		pnpm)
			echo "https://github.com/pnpm/pnpm/releases/download/v${2}/pnpm-linux-arm64" ;;
		prometheus)
			echo "https://github.com/prometheus/prometheus/releases/download/v${2}/prometheus-${2}.linux-arm64.tar.gz" ;;
		prysm-beacon)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${2}/beacon-chain-v${2}-linux-arm64" ;;
		prysm-stats)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${2}/client-stats-v${2}-linux-arm64" ;;
		prysmctl)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${2}/prysmctl-v${2}-linux-arm64" ;;
		qdrant)
			echo "https://github.com/qdrant/qdrant/releases/download/v${2}/qdrant-aarch64-unknown-linux-musl.tar.gz" ;;
		reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${2}/reth-v${2}-aarch64-unknown-linux-gnu.tar.gz" ;;
		sass)
			echo "https://github.com/sass/dart-sass/releases/download/${2}/dart-sass-${2}-linux-arm64.tar.gz" ;;
		snitch)
			echo "https://github.com/karol-broda/snitch/releases/download/v${2}/snitch_${2}_linux_arm64.tar.gz" ;;
		solana)
			echo "" ;;
		stashapp)
			echo "https://github.com/stashapp/stash/releases/download/v${2}/stash-linux-arm64v8" ;;
		stashbox)
			echo "https://github.com/stashapp/stash-box/releases/download/v${2}/stash-box-linux" ;;
		sui)
			echo "https://github.com/MystenLabs/sui/releases/download/mainnet-v${2}/sui-mainnet-v${2}-ubuntu-aarch64.tgz" ;;
		syncthing)
			echo "https://github.com/syncthing/syncthing/releases/download/v${2}/syncthing-linux-arm64-v${2}.tar.gz" ;;
		syncthrelay)
			echo "https://github.com/syncthing/relaysrv/releases/download/v${2}/strelaysrv-linux-arm64-v${2}.tar.gz" ;;
		syncthdiscv)
			echo "https://github.com/syncthing/discosrv/releases/download/v${2}/stdiscosrv-linux-arm64-v${2}.tar.gz" ;;
		tabby)
			echo "https://github.com/Eugeny/tabby/releases/download/v${2}/tabby-${2}-linux-arm64.tar.gz" ;;
		telegram)
			echo "https://github.com/telegramdesktop/tdesktop/releases/download/v${2}/tsetup.${2}.tar.xz" ;;
		thunderbird)
			echo "" ;;
		tufw)
			echo "https://github.com/peltho/tufw/releases/download/v${2}/tufw_${2}_linux_amd64.tar.gz" ;;
		uv)
			echo "https://github.com/astral-sh/uv/releases/download/${2}/uv-aarch64-unknown-linux-gnu.tar.gz" ;;
		viction)
			echo "https://github.com/BuildOnViction/victionchain/archive/refs/tags/v${2}.tar.gz" ;;
		vscode)
			echo "https://update.code.visualstudio.com/${2}/linux-arm64/stable" ;;
		waterfox)
			echo "https://cdn.waterfox.com/waterfox/releases/${2}/Linux_arm64/waterfox-${2}.tar.bz2" ;;
		yellowstone-grpc)
			echo "" ;;
		ytdlp)
			echo "https://github.com/yt-dlp/yt-dlp/releases/download/${2}/yt-dlp_linux_aarch64" ;;
		zenith)
			echo "https://github.com/bvaisvil/zenith/releases/download/${2}/zenith-Linux-musl-arm64.tar.gz" ;;
		*) echo "" ;;
	esac
}

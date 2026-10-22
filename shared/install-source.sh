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
	_program_id="${1}"
	case "${_program_id}" in
		7z) echo "ip7z" ;;
		agave) echo "anza-xyz" ;;
		base-node) echo "base" ;;
		bifrost-http) echo "maximhq" ;;
		bsc-erigon) echo "node-real" ;;
		bsc-geth) echo "bnb-chain" ;;
		bsc-reth) echo "bnb-chain" ;;
		btop) echo "aristocratos" ;;
		bun) echo "oven-sh" ;;
		composer) echo "composer" ;;
		doublecmd) echo "doublecmd" ;;
		erigon) echo "erigontech" ;;
		etcd) echo "etcd-io" ;;
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
		localai) echo "mudler" ;;
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
		vic-geth) echo "BuildOnViction" ;;
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
	_program_id="${1}"
	case "${_program_id}" in
		7z) echo "7zip" ;;
		agave) echo "agave" ;;
		base-node) echo "base" ;;
		bifrost-http) echo "bifrost" ;;
		bsc-erigon) echo "bsc-erigon" ;;
		bsc-geth) echo "bsc" ;;
		bsc-reth) echo "reth-bsc" ;;
		btop) echo "btop" ;;
		bun) echo "bun" ;;
		composer) echo "composer" ;;
		doublecmd) echo "doublecmd" ;;
		erigon) echo "erigon" ;;
		etcd) echo "etcd" ;;
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
		localai) echo "LocalAI" ;;
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
		vic-geth) echo "vic-geth" ;;
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
	_program_id="${1}"
	_version="${2}"
	case "${_program_id}" in
		7z)
			_v_nodot=$(echo "${_version}" | sed 's/\.//g')
			echo "https://github.com/ip7z/7zip/releases/download/${_version}/7z${_v_nodot}-linux-x64.tar.xz" ;;
		agave)
			echo "https://github.com/anza-xyz/agave/archive/refs/tags/v${_version}.tar.gz" ;;
		base-node)
			echo "https://github.com/base/base/releases/download/v${_version}/base-consensus-v${_version}-x86_64-unknown-linux-gnu.tar.gz" ;;
		base-reth)
			echo "https://github.com/base/base/releases/download/v${_version}/base-reth-node-v${_version}-x86_64-unknown-linux-gnu.tar.gz" ;;
		basectl)
			echo "https://github.com/base/base/releases/download/v${_version}/basectl-v${_version}-x86_64-unknown-linux-gnu.tar.gz" ;;
		bifrost-http)
			echo "https://downloads.getmaxim.ai/bifrost/v${_version}/linux/amd64/bifrost-http" ;;
		bsc-erigon)
			echo "https://github.com/node-real/bsc-erigon/releases/download/v${_version}/bsc-erigon_v${_version}_linux_amd64v2.tar.gz" ;;
		bsc-geth)
			echo "https://github.com/bnb-chain/bsc/releases/download/v${_version}/geth_linux" ;;
		bsc-reth)
			echo "https://github.com/bnb-chain/reth-bsc/archive/refs/tags/v${_version}.tar.gz" ;;
		btop)
			echo "https://github.com/aristocratos/btop/releases/download/v${_version}/btop-x86_64-unknown-linux-musl.tar.gz" ;;
		bun)
			echo "https://github.com/oven-sh/bun/releases/download/bun-v${_version}/bun-linux-x64.zip" ;;
		composer)
			echo "https://github.com/composer/composer/releases/download/${_version}/composer.phar" ;;
		doublecmd)
			echo "https://github.com/doublecmd/doublecmd/releases/download/v${_version}/doublecmd-${_version}.qt.x86_64.tar.xz" ;;
		erigon)
			echo "https://github.com/erigontech/erigon/releases/download/v${_version}/erigon_v${_version}_linux_amd64v2.tar.gz" ;;
		etcd)
			echo "https://github.com/etcd-io/etcd/releases/download/v${_version}/etcd-v${_version}-linux-amd64.tar.gz" ;;
		firefox)
			echo "https://ftp.mozilla.org/pub/firefox/releases/${_version}/linux-x86_64/en-US/firefox-${_version}.tar.xz" ;;
		foundry)
			echo "https://github.com/foundry-rs/foundry/releases/download/v${_version}/foundry_v${_version}_linux_amd64.tar.gz" ;;
		geth)
			echo "https://github.com/ethereum/go-ethereum/archive/refs/tags/v${_version}.tar.gz" ;;
		gitea)
			echo "https://github.com/go-gitea/gitea/releases/download/v${_version}/gitea-${_version}-linux-amd64" ;;
		go)
			echo "https://go.dev/dl/go${_version}.linux-amd64.tar.gz" ;;
		golangci-lint)
			echo "https://github.com/golangci/golangci-lint/releases/download/v${_version}/golangci-lint-${_version}-linux-amd64.tar.gz" ;;
		grafana-alloy)
			echo "https://github.com/grafana/alloy/releases/download/v${_version}/alloy-linux-amd64.zip" ;;
		grafana-loki)
			echo "https://github.com/grafana/loki/releases/download/v${_version}/loki-linux-amd64.zip" ;;
		hugo)
			echo "https://github.com/gohugoio/hugo/releases/download/v${_version}/hugo_extended_withdeploy_${_version}_linux-amd64.tar.gz" ;;
		jellyfin)
			echo "https://repo.jellyfin.org/files/server/linux/stable/v${_version}/amd64/jellyfin_${_version}-amd64.tar.xz" ;;
		just)
			echo "https://github.com/casey/just/releases/download/${_version}/just-${_version}-x86_64-unknown-linux-musl.tar.gz" ;;
		localai)
			echo "https://github.com/mudler/LocalAI/releases/download/v${_version}/local-ai-v${_version}-linux-amd64" ;;
		ollama)
			echo "https://github.com/ollama/ollama/releases/download/v${_version}/ollama-linux-amd64.tar.zst" ;;
		op-reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${_version}/op-reth-v${_version}-x86_64-unknown-linux-gnu.tar.gz" ;;
		op-node)
			echo "https://github.com/ethereum-optimism/optimism/archive/refs/tags/v${_version}.tar.gz" ;;
		opencode)
			echo "https://github.com/anomalyco/opencode/releases/download/v${_version}/opencode-linux-x64.tar.gz" ;;
		opencode-desktop)
			echo "https://github.com/anomalyco/opencode/releases/download/v${_version}/opencode-desktop-linux-x86_64.AppImage" ;;
		pgweb)
			echo "https://github.com/sosedoff/pgweb/releases/download/v${_version}/pgweb_linux_amd64.zip" ;;
		pnpm)
			echo "https://github.com/pnpm/pnpm/releases/download/v${_version}/pnpm-linux-x64" ;;
		prometheus)
			echo "https://github.com/prometheus/prometheus/releases/download/v${_version}/prometheus-${_version}.linux-amd64.tar.gz" ;;
		prysm-beacon)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${_version}/beacon-chain-v${_version}-modern-linux-amd64" ;;
		prysm-stats)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${_version}/client-stats-v${_version}-linux-amd64" ;;
		prysmctl)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${_version}/prysmctl-v${_version}-linux-amd64" ;;
		qdrant)
			echo "https://github.com/qdrant/qdrant/releases/download/v${_version}/qdrant-x86_64-unknown-linux-musl.tar.gz" ;;
		reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${_version}/reth-v${_version}-x86_64-unknown-linux-gnu.tar.gz" ;;
		sass)
			echo "https://github.com/sass/dart-sass/releases/download/${_version}/dart-sass-${_version}-linux-x64.tar.gz" ;;
		snitch)
			echo "https://github.com/karol-broda/snitch/releases/download/v${_version}/snitch_${_version}_linux_amd64.tar.gz" ;;
		solana)
			echo "https://github.com/solana-labs/solana/releases/download/v${_version}/solana-release-x86_64-unknown-linux-gnu.tar.bz2" ;;
		stashapp)
			echo "https://github.com/stashapp/stash/releases/download/v${_version}/stash-linux" ;;
		stashbox)
			echo "https://github.com/stashapp/stash-box/releases/download/v${_version}/stash-box-linux" ;;
		sui)
			echo "https://github.com/MystenLabs/sui/releases/download/mainnet-v${_version}/sui-mainnet-v${_version}-ubuntu-x86_64.tgz" ;;
		syncthing)
			echo "https://github.com/syncthing/syncthing/releases/download/v${_version}/syncthing-linux-amd64-v${_version}.tar.gz" ;;
		syncthrelay)
			echo "https://github.com/syncthing/relaysrv/releases/download/v${_version}/strelaysrv-linux-amd64-v${_version}.tar.gz" ;;
		syncthdiscv)
			echo "https://github.com/syncthing/discosrv/releases/download/v${_version}/stdiscosrv-linux-amd64-v${_version}.tar.gz" ;;
		tabby)
			echo "https://github.com/Eugeny/tabby/releases/download/v${_version}/tabby-${_version}-linux-x64.tar.gz" ;;
		telegram)
			echo "https://github.com/telegramdesktop/tdesktop/releases/download/v${_version}/tsetup.${_version}.tar.xz" ;;
		thunderbird)
			echo "https://ftp.mozilla.org/pub/thunderbird/releases/${_version}/linux-x86_64/en-US/thunderbird-${_version}.tar.xz" ;;
		tufw)
			echo "https://github.com/peltho/tufw/releases/download/v${_version}/tufw_${_version}_linux_amd64.tar.gz" ;;
		uv)
			echo "https://github.com/astral-sh/uv/releases/download/${_version}/uv-x86_64-unknown-linux-gnu.tar.gz" ;;
		vic-geth)
			echo "https://github.com/BuildOnViction/vic-geth/releases/download/v${_version}/vic-geth-v${_version}-linux-amd64.tar.zst" ;;
		viction)
			echo "https://github.com/BuildOnViction/victionchain/releases/download/v${_version}/tomo-linux-amd64" ;;
		vscode)
			echo "https://update.code.visualstudio.com/${_version}/linux-x64/stable" ;;
		waterfox)
			echo "https://cdn.waterfox.com/waterfox/releases/${_version}/Linux_x86_64/waterfox-${_version}.tar.bz2" ;;
		yellowstone-grpc)
			echo "" ;;
		ytdlp)
			echo "https://github.com/yt-dlp/yt-dlp/releases/download/${_version}/yt-dlp_linux" ;;
		zenith)
			echo "https://github.com/bvaisvil/zenith/releases/download/${_version}/zenith-Linux-musl-x86_64.tar.gz" ;;
		*) echo "" ;;
	esac
}

# ------------------------------------------------------------------------------
# Return the download URI for ARM64 for a Program ID.
# ------------------------------------------------------------------------------
get_download_uri_arm64() {
	_program_id="${1}"
	_version="${2}"
	case "${_program_id}" in
		7z)
			_v_nodot=$(echo "${_version}" | sed 's/\.//g')
			echo "https://github.com/ip7z/7zip/releases/download/${_version}/7z${_v_nodot}-linux-arm64.tar.xz" ;;
		agave)
			echo "https://github.com/anza-xyz/agave/archive/refs/tags/v${_version}.tar.gz" ;;
		base-node)
			echo "https://github.com/base/base/releases/download/v${_version}/base-consensus-v${_version}-aarch64-unknown-linux-gnu.tar.gz" ;;
		base-reth)
			echo "https://github.com/base/base/releases/download/v${_version}/base-reth-node-v${_version}-aarch64-unknown-linux-gnu.tar.gz" ;;
		basectl)
			echo "https://github.com/base/base/releases/download/v${_version}/basectl-v${_version}-aarch64-unknown-linux-gnu.tar.gz" ;;
		bifrost-http)
			echo "https://downloads.getmaxim.ai/bifrost/v${_version}/linux/arm64/bifrost-http" ;;
		bsc-erigon)
			echo "https://github.com/node-real/bsc-erigon/releases/download/v${_version}/bsc-erigon_v${_version}_linux_arm64.tar.gz" ;;
		bsc-geth)
			echo "https://github.com/bnb-chain/bsc/releases/download/v${_version}/geth-linux-arm64" ;;
		bsc-reth)
			echo "https://github.com/bnb-chain/reth-bsc/archive/refs/tags/v${_version}.tar.gz" ;;
		btop)
			echo "https://github.com/aristocratos/btop/releases/download/v${_version}/btop-aarch64-unknown-linux-musl.tar.gz" ;;
		bun)
			echo "https://github.com/oven-sh/bun/releases/download/bun-v${_version}/bun-linux-aarch64.zip" ;;
		composer)
			echo "https://github.com/composer/composer/releases/download/${_version}/composer.phar" ;;
		doublecmd)
			echo "https://github.com/doublecmd/doublecmd/releases/download/v${_version}/doublecmd-${_version}.qt.aarch64.tar.xz" ;;
		erigon)
			echo "https://github.com/erigontech/erigon/releases/download/v${_version}/erigon_v${_version}_linux_arm64.tar.gz" ;;
		etcd)
			echo "https://github.com/etcd-io/etcd/releases/download/v${_version}/etcd-v${_version}-linux-arm64.tar.gz" ;;
		firefox)
			echo "https://ftp.mozilla.org/pub/firefox/releases/${_version}/linux-aarch64/en-US/firefox-${_version}.tar.xz" ;;
		foundry)
			echo "https://github.com/foundry-rs/foundry/releases/download/v${_version}/foundry_v${_version}_linux_arm64.tar.gz" ;;
		geth)
			echo "https://github.com/ethereum/go-ethereum/archive/refs/tags/v${_version}.tar.gz" ;;
		gitea)
			echo "https://github.com/go-gitea/gitea/releases/download/v${_version}/gitea-${_version}-linux-arm64" ;;
		go)
			echo "https://go.dev/dl/go${_version}.linux-arm64.tar.gz" ;;
		golangci-lint)
			echo "https://github.com/golangci/golangci-lint/releases/download/v${_version}/golangci-lint-${_version}-linux-arm64.tar.gz" ;;
		hugo)
			echo "https://github.com/gohugoio/hugo/releases/download/v${_version}/hugo_extended_withdeploy_${_version}_linux-arm64.tar.gz" ;;
		grafana-alloy)
			echo "https://github.com/grafana/alloy/releases/download/v${_version}/alloy-linux-arm64.zip" ;;
		grafana-loki)
			echo "https://github.com/grafana/loki/releases/download/v${_version}/loki-linux-arm64.zip" ;;
		jellyfin)
			echo "https://repo.jellyfin.org/files/server/linux/stable/v${_version}/arm64/jellyfin_${_version}-arm64.tar.xz" ;;
		just)
			echo "https://github.com/casey/just/releases/download/${_version}/just-${_version}-aarch64-unknown-linux-musl.tar.gz" ;;
		localai)
			echo "https://github.com/mudler/LocalAI/releases/download/v${_version}/local-ai-v${_version}-linux-arm64" ;;
		ollama)
			echo "https://github.com/ollama/ollama/releases/download/v${_version}/ollama-linux-arm64.tar.zst" ;;
		op-reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${_version}/op-reth-v${_version}-aarch64-unknown-linux-gnu.tar.gz" ;;
		op-node)
			echo "https://github.com/ethereum-optimism/optimism/archive/refs/tags/v${_version}.tar.gz" ;;
		opencode)
			echo "https://github.com/anomalyco/opencode/releases/download/v${_version}/opencode-linux-arm64.tar.gz" ;;
		opencode-desktop)
			echo "https://github.com/anomalyco/opencode/releases/download/v${_version}/opencode-desktop-linux-arm64.AppImage" ;;
		pgweb)
			echo "https://github.com/sosedoff/pgweb/releases/download/v${_version}/pgweb_linux_arm64.zip" ;;
		pnpm)
			echo "https://github.com/pnpm/pnpm/releases/download/v${_version}/pnpm-linux-arm64" ;;
		prometheus)
			echo "https://github.com/prometheus/prometheus/releases/download/v${_version}/prometheus-${_version}.linux-arm64.tar.gz" ;;
		prysm-beacon)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${_version}/beacon-chain-v${_version}-linux-arm64" ;;
		prysm-stats)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${_version}/client-stats-v${_version}-linux-arm64" ;;
		prysmctl)
			echo "https://github.com/OffchainLabs/prysm/releases/download/v${_version}/prysmctl-v${_version}-linux-arm64" ;;
		qdrant)
			echo "https://github.com/qdrant/qdrant/releases/download/v${_version}/qdrant-aarch64-unknown-linux-musl.tar.gz" ;;
		reth)
			echo "https://github.com/paradigmxyz/reth/releases/download/v${_version}/reth-v${_version}-aarch64-unknown-linux-gnu.tar.gz" ;;
		sass)
			echo "https://github.com/sass/dart-sass/releases/download/${_version}/dart-sass-${_version}-linux-arm64.tar.gz" ;;
		snitch)
			echo "https://github.com/karol-broda/snitch/releases/download/v${_version}/snitch_${_version}_linux_arm64.tar.gz" ;;
		solana)
			echo "" ;;
		stashapp)
			echo "https://github.com/stashapp/stash/releases/download/v${_version}/stash-linux-arm64v8" ;;
		stashbox)
			echo "https://github.com/stashapp/stash-box/releases/download/v${_version}/stash-box-linux" ;;
		sui)
			echo "https://github.com/MystenLabs/sui/releases/download/mainnet-v${_version}/sui-mainnet-v${_version}-ubuntu-aarch64.tgz" ;;
		syncthing)
			echo "https://github.com/syncthing/syncthing/releases/download/v${_version}/syncthing-linux-arm64-v${_version}.tar.gz" ;;
		syncthrelay)
			echo "https://github.com/syncthing/relaysrv/releases/download/v${_version}/strelaysrv-linux-arm64-v${_version}.tar.gz" ;;
		syncthdiscv)
			echo "https://github.com/syncthing/discosrv/releases/download/v${_version}/stdiscosrv-linux-arm64-v${_version}.tar.gz" ;;
		tabby)
			echo "https://github.com/Eugeny/tabby/releases/download/v${_version}/tabby-${_version}-linux-arm64.tar.gz" ;;
		telegram)
			echo "https://github.com/telegramdesktop/tdesktop/releases/download/v${_version}/tsetup.${_version}.tar.xz" ;;
		thunderbird)
			echo "" ;;
		tufw)
			echo "https://github.com/peltho/tufw/releases/download/v${_version}/tufw_${_version}_linux_amd64.tar.gz" ;;
		uv)
			echo "https://github.com/astral-sh/uv/releases/download/${_version}/uv-aarch64-unknown-linux-gnu.tar.gz" ;;
		vic-geth)
			echo "https://github.com/BuildOnViction/vic-geth/releases/download/v${_version}/vic-geth-v${_version}-linux-arm64.tar.zst" ;;
		viction)
			echo "https://github.com/BuildOnViction/victionchain/releases/download/v${_version}/tomo-linux-arm64" ;;
		vscode)
			echo "https://update.code.visualstudio.com/${_version}/linux-arm64/stable" ;;
		waterfox)
			echo "https://cdn.waterfox.com/waterfox/releases/${_version}/Linux_arm64/waterfox-${_version}.tar.bz2" ;;
		yellowstone-grpc)
			echo "" ;;
		ytdlp)
			echo "https://github.com/yt-dlp/yt-dlp/releases/download/${_version}/yt-dlp_linux_aarch64" ;;
		zenith)
			echo "https://github.com/bvaisvil/zenith/releases/download/${_version}/zenith-Linux-musl-arm64.tar.gz" ;;
		*) echo "" ;;
	esac
}

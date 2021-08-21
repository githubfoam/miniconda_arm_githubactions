IMAGE := alpine/fio
APP:="scripts/usernetes-containerd.sh"

deploy-miniconda-arm32:
	bash scripts/deploy-miniconda-arm32.sh

deploy-miniconda-arm64:
	bash scripts/deploy-miniconda-arm64.sh


push-image:
	docker push $(IMAGE)

.PHONY: push-image

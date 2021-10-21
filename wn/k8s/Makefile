
all: secret_pool_isfiligoi

secret_pool_isfiligoi:
	-kubectl delete secret t2-htcondor-wn-secret -n cms-ucsd-t2
	kubectl create secret generic t2-htcondor-wn-secret -n cms-ucsd-t2 --from-file=prp-wn.token=t2-wn-cms-ucsd-t2.token

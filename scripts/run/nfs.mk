nfs_export:
	cp $(TOPDIR)/nfs/send/* /nfsroot/

nfs_import:
	cp /nfsroot/* $(TOPDIR)/nfs/recv/

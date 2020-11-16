# Permissions
The Imixs Wildfly container start the wildfly server with a non-privileged system user having the uid and gid 901.

If you share a volume from your host to container, make sure that the user 901 has write permissions for the corresponding host directories:

	$ chgrp -R 901 deployments/
	$ chmod 775 -R deployments/


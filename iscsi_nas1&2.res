resource iscsi{
	protocol C;
	device /dev/drbd0;
	disk /dev/sdb1;
	meta-disk internal;

	startup {
		become-primary-on nas1;
	}
	disk {
		on-io-error detach;
	}
	net {
		after-sb-0pri discard-older-primary;
		after-sb-1pri call-pri-lost-after-sb;
		after-sb-2pri call-pri-lost-after-sb;
	}
	syncer {
		rate 100M;
	}
	on nas1 {
		address 172.17.1.20:7788;
	}
	on nas2 {
		address 172.17.1.21:7788;
	}
}

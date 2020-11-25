#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include <sys/socket.h> 
#include <sys/stat.h>
#include <sys/ioctl.h>

#include <unistd.h>
#include <fcntl.h>
#include <linux/if.h>
#include <linux/if_tun.h>




int tun_alloc(char *dev)
{
	struct ifreq ifr;
	int fd, err;
	if( (fd = open("/dev/net/tun", O_RDWR)) < 0 ){
		perror("alloc tun");
		exit(-1);
	}

	memset(&ifr, 0, sizeof(ifr));

  /* Flags: IFF_TUN   - TUN device (no Ethernet headers) 
   *        IFF_TAP   - TAP device  
   *
   *        IFF_NO_PI - Do not provide packet information  
   */ 
	ifr.ifr_flags = IFF_TUN; 
	if( *dev )
		strncpy(ifr.ifr_name, dev, IFNAMSIZ);

	if( (err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0 ){
		close(fd);
		return err;
	}

	strcpy(dev, ifr.ifr_name);

	return fd;
}      

void catchPackets(char *tun_name, int dest){
	int tunfd;
	unsigned char buffer[1500];
	int nread;
	char command[50];

	tunfd = tun_alloc(tun_name);

	
	system("chmod +x configure-tun.sh");

	strcpy(command, "./configure-tun.sh");
	system(command);
	if(tunfd < 0){
		perror("Allocating interface");
		exit(1);
	}


	while(1) {
		nread = read(tunfd,buffer,sizeof(buffer));
		if(nread < 0) {
			perror("Reading from interface");
			close(tunfd);
			exit(1);
		}
		write(dest, buffer, nread);
		printf("\n");
	}
}

int main (int argc, char** argv){

	if (argc != 2) {
		printf("Usage Error \n");
		return 1;
	}

	catchPackets(argv[1], 1);

	return 0;
}


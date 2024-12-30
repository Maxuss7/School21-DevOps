#include <fcgi_stdio.h>

int main() {
    while (FCGI_Accept() >= 0) {
        printf("Content-type: text/html\r\n\r\n");
        
        printf("<html><head><title>Hello FastCGI</title></head>");
        printf("<body><h1>Hello World!</h1></body></html>");
    }
    return 0;
}

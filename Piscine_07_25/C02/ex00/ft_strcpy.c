#include <stdio.h>

char    *ft_strcpy(char *dest, char *src)
{
    int i;

    i = 0;
    while (src[i] != '\0')
    {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return dest;
}

/*int main(void)
{
    char src[] = "thesource";
    char dest[100];

    printf("La source: %s, La destination: %s\n", src, dest);
    ft_strcpy(dest, src);
    printf("La source: %s, La destination: %s\n", src, dest);
    return (0);
}*/

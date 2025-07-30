#include <stdlib.h>
#include <stdio.h>

int	ft_strlen(char *str)
{
	int	i;

	i = 0;
	while (str[i])
	{
		i++;
	}
	return (i);
}

char	*ft_strcpy(char *dest, char *src)
{
	int	i;

	i = 0;
	while (src[i] != '\0')
	{
		dest[i] = src[i];
		i++;
	}
	dest[i] = '\0';
	return (dest);
}

char	*ft_strdup(char *src)
{
	char	*dest;

	dest = malloc(sizeof(char)*ft_strlen(src));
	ft_strcpy(dest, src);
	return (dest);
}

/*int	main(void)
{
	char *src = "entree";
	char *dest = "";

	printf("chaine source : %s\n", src);
	printf("chaine dest : %s\n", dest);
	dest = ft_strdup(src);
	printf("apres chaine dest copie : %s\n", dest);
	printf("apres chaine source : %s\n", src);
}*/

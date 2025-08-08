/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nlopinet <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/26 18:00:56 by nlopinet          #+#    #+#             */
/*   Updated: 2025/07/26 18:00:59 by nlopinet         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

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

/*int	main(void)
{
	printf("nombre de caracteres: %d\n", ft_strlen("mot"));
	printf("nombre de caracteres: %d\n", ft_strlen("motus"));
	printf("nombre de caracteres: %d\n", ft_strlen(""));
	return (0);
}*/

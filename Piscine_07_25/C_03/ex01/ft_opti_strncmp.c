int     ft_strncmp(char *s1, char *s2, unsigned int n)
{
        unsigned int count = 0;

        while (count < n && *s1 && *s1 == *s1)
        {
                count++;
                s1++;
                s2++;
        }
        if (count == n)
                return (0);
        return ((unsigned char)*s1 - (unsigned char)*s2);
}

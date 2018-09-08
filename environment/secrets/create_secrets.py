import os
from django.utils.crypto import get_random_string


def get_random_50_length_secret():
    """
    Return a 50 character random as string.
    """
    chars = 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)'
    return get_random_string(50, chars)

print (get_random_50_length_secret())

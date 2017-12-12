## S-DES Brute Force Attack

+ The [brute force attack PowerShell script](https://github.com/tmwatchanan/S-DES-brute-force-attack/blob/master/sdes_attack.ps1) was done by [me](http://github.com/tmwatchanan).
+ The Simplified-DES implementation was done by [Kevin O'Connor](http://kevin.oconnor.mp).

### There is a bug in his code
```cpp
} else if(method == "decrypt") {
		if(!des.set_key(key))
		{
			help();
			return 0;
		}
		if(!des.set_cipher(cipher_plain))
		{
			help();
			return 0;
		}
		std::cout << "Ciphertext:\t" << cipher_plain << "\n\rKey:\t\t" << key << "\n\rPlaintext:\t";
		std::cout << des.encrypt() << std::endl;
}
```
You need to change `des.encrypt()` to `des.decrypt()`

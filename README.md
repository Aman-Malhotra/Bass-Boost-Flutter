# bass_boost

#### A flutter plugin to increase bass in any audio.

## Initialize the object of BassBoost class like this
```
 BassBoost bassBoost = new BassBoost( id );
 // id here is the audioSessionId for the playing audio.
 ```
## Enable it by calling the function setEnabled(bool b) using the same object initialized above

`bassBoost.setEnabled(true);`

## Change the strength of bass by calling the function setStrength(int strength) on the object initialized above

```
bassBoost.setStrength(i);
//i = intger value ranging from 0 to 1000 including the extremes ([0,1000]) . 
//All values less than 0 and greater than 1000 will be neglected
```

## Check whether the bass is already enabled or not by calling the function getEnabled() using the same object initialized above

`bool b = await bassBoost.getEnabled();//b will get a boolean value in return.`


## Get current strength of the bass by calling getStrength() using the same object initialized above

`int strength = await bassBoost.getStrength();//strength will get an integer value in return.`

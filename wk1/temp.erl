
-module(temp).

-export([convert/2]).

tempc2f(C) -> trunc(C * 1.8 + 32).

tempf2c(F) -> trunc((F - 32) / 1.8).

convert(c, Temp) -> {c, tempc2f(Temp)};
	   
convert(f, Temp) -> {f, tempf2c(Temp)};

convert(_, _) -> throw(unrecognized_unit).
    
	





(SynthDef(\sax, { |out, freq=440, amp=0.1, gate=1|
	var num = 16;
	var harms = Array.series(num, 1, 1) * Array.exprand(num, 0.995, 1.001);
	var snd = Saw.ar(freq * SinOsc.kr(Rand(2.0,5.0),0,Rand(0.001, 0.01),1) * harms, mul:Array.geom(num, 1, 0.63));
	snd = Splay.ar(snd);
	snd = BBandPass.ar(snd, freq * XLine.kr(0.1,4,0.01), 2);
	snd = snd * amp * EnvGen.ar(Env.adsr(0.001, 0.2, 0.7, 0.2), gate, doneAction:2);
	Out.ar(out, snd!2);
}).add;

)


(
TempoClock.default.tempo = 2.1;

Pdef(\sax).quant = 4;


// needs more articulation...
Pdef(\sax, Pbind(
	\instrument, \sax,
	\root, 3,
	\scale, Scale.minor,
	\octave, 5,
	\legato, 0.75,
	\amp, Pwhite(0.9,1.0, inf),
	\degree, Pseq([Pseq([Pn(4,4),3,4],2), Pseq([4,6,4,3,2,0,0,1,2,0])], inf),
	\dur, Pseq([Pseq([2,1/2,Pn(1/4,3),3/4],2), Pseq([1.5,1,1,1,1,Pn(0.5,5)])], inf)
)).play;
)

Pwhite(0.9,1.0, inf)
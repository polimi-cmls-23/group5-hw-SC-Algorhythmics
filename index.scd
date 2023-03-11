// todo noise, sawtooth, squared,
SynthDef(\sax, { |out, freq=440, amp=0.1, gate=1|

	var num = 16;
	// generate [1,...16]=> get random values
	var harms = Array.series(num, 1, 1) * Array.exprand(num, 0.995, 1.001);
	// SinOsc.kr(freq: 440.0, phase: 0.0, mul: 1.0, add: 0.0)
	var snd = SinOsc.ar(freq * SinOsc.kr(Rand(2.0,5.0),0,Rand(0.001, 0.01),1) * harms, mul:Array.geom(num, 1, 0.63));
	// change channel: Splay.ar(inArray, spread: 1, level: 1, center: 0.0, levelComp: true)
	snd = Splay.ar(snd);

	snd = BBandPass.ar(snd, freq * XLine.kr(0.1,4,0.01), 2);
	snd = snd * amp * EnvGen.ar(Env.adsr(0.001, 0.2, 0.7, 0.2), gate, doneAction:2);

	Out.ar(out, snd!2);
}).add;
)



// change shape by shape knob
(
var win = Window.new("Knob", Rect(300,300,240,100));
var button = Button.new(win, Rect(150, 30, 50, 50));
)

s = Synth.new(\sax);
s.set(\amp, 0.3);
s.scope;
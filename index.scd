s.boot;
// todo noise, sawtooth, squared,
(x = SynthDef(\sax, { |out, freq=440, amp=0.1, gate=1|

	var num = 16;
	// generate [1,...16]=> get random values
	var harms = Array.series(num, 1, 1) * Array.exprand(num, 0.995, 1.001);
	// SinOsc.kr(freq: 440.0, phase: 0.0, mul: 1.0, add: 0.0)
	var snd = Saw.ar(freq * SinOsc.kr(Rand(2.0,5.0),0,Rand(0.001, 0.01),1) * harms, mul:Array.geom(num, 1, 0.63));
	// change channel: Splay.ar(inArray, spread: 1, level: 1, center: 0.0, levelComp: true)
	snd = Splay.ar(snd);

	snd = BBandPass.ar(snd, freq * XLine.kr(0.1,4,0.01), 2);
	snd = snd * amp * EnvGen.ar(Env.adsr(0.001, 0.2, 0.7, 0.2), gate, doneAction:2);

	Out.ar(out, snd!2);
}).add;
)

// set gui style
(
w = Window.new("window").front;
w.background_(Color.white(0.7));
// set popup menu
m = PopUpMenu(w, Rect(10, 10, 180, 20));
m.items = [
	"Saw","Pulse","WhiteNoise"
];

m.background_(Color.grey(0.8));
m.stringColor_(Color.black);
m.font_(Font("Courier", 13));
m.action = { arg menu;
 [menu.value, menu.item].postln;
};
// add play button
b = Button.new(w, Rect(10, 40, 50, 25)).states_([["Play", Color.black], ["Stop", Color.red]]);
// b = Button(w, Rect(10, 40, 50, 25));
// b.string = "play/stop";
b.action_({
	if (b.value == 1, {
        x.play;
	},{
		s.free;
		// Synth.free;

	})
});
)

// play
(

s = Synth(\sax);

)

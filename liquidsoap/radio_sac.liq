set("log.level", 4)
set("log.file", false)

# Resolver

def next_track() =
  log("SAC: requesting next track...")
  filepath = get_process_output("/usr/bin/python3 /app/resolver/resolver.py")
  filepath = string.trim(filepath)
  log("SAC: selected #{filepath}")
  request.create(filepath)
end

radio = request.dynamic(next_track)

# Core processing
radio = normalize(radio)
radio = crossfade(duration=7., fade_out=7., fade_in=0.1, radio)
radio = audio_to_stereo(radio)

# DSP chain
radio = ladspa.sc4(radio,
  rms_peak=0.,
  attack_time=50.,
  release_time=400.,
  threshold_level=-18.,
  ratio=3.,
  knee_radius=3.,
  makeup_gain=6.
)

radio = ladspa.dysoncompress(radio,
  peak_limit=0.,
  release_time=0.25,
  fast_compression_ratio=0.5,
  compression_ratio=0.7
)

radio = ladspa.mbeq(
  _10000hz_gain=0.,
  _100hz_gain=2.,
  _1250hz_gain=0.,
  _156hz_gain=0.,
  _1750hz_gain=0.,
  _20000hz_gain=0.,
  _220hz_gain=0.,
  _2500hz_gain=0.,
  _311hz_gain=-1.,
  _3500hz_gain=1.,
  _440hz_gain=0.,
  _5000hz_gain=1.,
  _50hz_gain=2.,
  _622hz_gain=0.,
  _880hz_gain=0.,
  radio
)

radio = ladspa.fastlookaheadlimiter(radio,
  input_gain=0.,
  limit=-1.,
  release_time=0.05
)

safe = fallback(track_sensitive=false, [radio, blank()])

output.icecast(
  %mp3(bitrate=192),
  host="icecast",
  port=8000,
  password="hackme",
  mount="/sac",
  name="SAC Runtime",
  description="Semantic Atmosphere Core Runtime",
  safe
)

schedule = [
  {
    repeat: 2,
    desc: "Quadriceps stretch. Stand and pull leg to bottom",
    duration: 30,
    alternate: ["right leg", "left leg"],
  },
  {
    repeat: 2,
    desc: "Lay on back and raise one leg",
    duration: 30,
    alternate: ["right leg", "left leg"],
  },
  {
    repeat: 2,
    desc: "Figure 4 stretch",
    duration: 30,
    alternate: ["right leg", "left leg"],
  },
  {
    repeat: 3,
    desc: "Do the diver 10 times",
    duration: 40,
    alternate: ["right leg", "left leg"],
  },
  {
    repeat: 3,
    desc: "Make a bridge 10 times",
    duration: 40,
    alternate: ["Arch your back"],
  },
  {
    repeat: 3,
    desc: "Split squat 10 times",
    duration: 40,
    alternate: ["right leg", "left leg"],
  },
]

schedule = [
  {
    repeat: 2,
    desc: "Quadriceps stretch. Stand and pull leg to bottom",
    duration: 5,
    alternate: ["right leg", "left leg"],
  },
]

entries = []
current_time = 0

schedule.each do |s|
  entries << { time: current_time, duration: 10, desc: "Prep for start new excercise in 10 seconds" }
  current_time = current_time + 10

  s[:repeat].times do |time|
    s[:alternate].each do |alt|
      entries << { time: current_time, duration: s[:duration], desc: "#{s[:desc]} #{alt} for #{s[:duration]} seconds" }
      current_time = current_time + s[:duration]
    end
  end
end

puts "🗓 Schedule:"

entries.each do |e|
  puts "🕰 #{e[:time]}s\t#{e[:duration]}\t#{e[:desc]}"
end

`say 'Total excercise time #{entries.last[:time]/60} minutes'`

start_time = Time.now

loop do
  time_now = Time.now
  elapsed = time_now.to_i - start_time.to_i
  print "🕰 #{elapsed}...\r"

  right_now = entries.find { |e| e[:time] == elapsed}

  if right_now
    puts right_now[:desc]
    `say '#{right_now[:desc]}'`
  end

  sleep 0.1
end

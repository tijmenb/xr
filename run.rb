schedule = [
  {
    repeat: 3,
    if: true,
    excercises: [
      {
        repeat: 3,
        desc: "Do the quadriceps stretch. Stand and pull up your",
        duration: 40,
        alternate: ["right leg", "left leg"],
      },
      {
        repeat: 3,
        desc: "Lay on your back and raise your",
        duration: 40,
        alternate: ["right leg", "left leg"],
      },
      {
        repeat: 3,
        desc: "Do the figure 4 stretch",
        duration: 40,
        alternate: ["right leg", "left leg"],
      },
    ]
  },
  {
    if: Time.now.day % 2 == 0,
    repeat: 3,
    excercises: [
      {
      desc: "Do the diver 10 times",
      duration: 30,
      alternate: ["right leg", "left leg"],
      },
      {
        desc: "Make a bridge 8 times and keep",
        duration: 30,
        alternate: ["your right leg in the air", "your left leg in the air"],
      },
      {
        desc: "Do the squat 10 times",
        duration: 40,
        alternate: ["and keep your right leg forward", "and keep your left leg forward"],
      },
    ]
  }
]

entries = []
current_time = 0

schedule.each do |s|
  unless s[:if]
    entries << { time: current_time, duration: 10, desc: "Skipping other excercises" }
    next
  end

  entries << { time: current_time, duration: 10, desc: "Prep for start new excercise in 10 seconds" }
  current_time = current_time + 10

  if !s[:excercises]
    exies = [s]
  else
    exies = s[:excercises]
  end

  s[:repeat].times do
    exies.each do |x|
      x[:alternate].each do |alt|
        entries << { time: current_time, duration: x[:duration], desc: "#{x[:desc]} #{alt} for #{x[:duration]} seconds" }
        current_time = current_time + x[:duration]
      end
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

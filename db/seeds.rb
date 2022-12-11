class Seeder
  class << self
    def call
      new.seed
    end
  end

  def seed
    puts "SEEDING"
    separator 2
    clean_db
    separator
    seed_users
    separator
    seed_moles
    separator
    seed_bookings
    separator 2
    puts "SEEDED"
  end

  private

  def separator(n = 1)
    puts "\n" * n
  end

  def clean_db
    classes = %w[ Booking Mole User ]
    classes.each do |cls|
      puts "Delete #{cls.pluralize}"
      cls.constantize.destroy_all 
      puts "#{cls.pluralize} deleted"
    end
  end

  def seed_users
    puts "Seeding users"
    data = [
      { email: 'test@test.com', password: 'azerty', first_name: 'Paul', last_name: 'Portier' },
      { email: 'jeantaupe@top.com', password: 'azerty', first_name: 'Jean', last_name: 'Taupe' },
      { email: 'alicetaupe@top.com', password: 'azerty', first_name: 'Alice', last_name: 'Taupe' },
    ]
    
    data.each_with_index { |d, i| instance_variable_set("@user_#{i + 1}", User.create!(d)) }
    puts "Users seeded"
  end

  def seed_moles
    puts "Seeding moles"
    data = [
      { 
        first_name: 'Taupy',
        last_name: 'La taupe',
        dob: Date.today,
        address: '16 villa Gaudelet, 75011 Paris',
        weight: rand(16..350),
        height: rand(2..25),
        width: rand(2..25),
        length: rand(7..50),
        shade: :mole,
        user: @user_1
      },
      { 
        first_name: 'Taupeuh',
        last_name: 'Grostaupe',
        dob: Date.today,
        address: '12 rue du sentier, 75002 Paris',
        weight: rand(16..350),
        height: rand(2..25),
        width: rand(2..25),
        length: rand(7..50),
        shade: :mole,
        user: @user_2
      },
      { 
        first_name: 'Taupette',
        last_name: 'Trètaupe',
        dob: Date.today,
        address: '35 rue Doudeauville, 75018 Paris',
        weight: rand(16..350),
        height: rand(2..25),
        width: rand(2..25),
        length: rand(7..50),
        shade: :mole,
        user: @user_3
      },
    ]
    
    data.each_with_index { |d, i| instance_variable_set("@mole_#{i + 1}", Mole.create!(d)) }
    puts "Moles seeded"
  end

  def seed_bookings
    puts "Seeding bookings"
      Mole.all.each_with_index do |mole, i|
        Booking.create!(
          mole: mole, 
          user: instance_variable_get("@user_#{i + 1}"),
          starts_at: (start = DateTime.current - rand(72..240).hours),
          ends_at: start + rand(12..55).hours
        )
      end
    puts "Bookings seeded"
  end
end

Seeder.call

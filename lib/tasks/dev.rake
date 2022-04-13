namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Dropando a DB!")
      spinner.auto_spin
      sleep(3)
    %x(rails db:drop)
    spinner.success("(Malfeito feito!)")
    spinner = TTY::Spinner.new("[:spinner] Criando a DB!")
      spinner.auto_spin
      sleep(3)
    %x(rails db:create)
    spinner.success("(Malfeito feito!)")
    spinner = TTY::Spinner.new("[:spinner] Migrando a Db!")
      spinner.auto_spin
      sleep(3)
    %x(rails db:migrate )
    spinner.success("(Malfeito feito!)")
    spinner = TTY::Spinner.new("[:spinner] Subindo as info!")
      spinner.auto_spin
      sleep(3)
    %x(rails db:seed)
    spinner.success("(Malfeito feito!)")
      spinner.stop("Done!")
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
     
   else 
      puts "Ambiente errado, otário!"
    end
   end
desc "Cadastra as moedas"
  task add_coins: :environment do
    
puts "Cadastrando moeda..."



coins= [
    
    {description: "Bitcoin",
    acronym: "BTC",
    url_image: "https://logosmarcas.net/wp-content/uploads/2020/08/Bitcoin-Logo.png",
    mining_type: MiningType.find_by(acronym: 'PoW')},
    
    
    {description: "Ethereum",
    acronym: "ETH",
    url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/640px-ETHEREUM-YOUTUBE-PROFILE-PIC.png", mining_type: MiningType.all.sample},
   
    
    
    {description: "Dash",
    acronym: "DASH",
    url_image: "https://www.pngkit.com/png/detail/135-1353048_dash-icon-dash-coin-logo-png.png", mining_type: MiningType.all.sample }]
  
    coins.each do |coin|
        Coin.find_or_create_by!(coin)
     end
   end


  desc "cadastro de tipo de mineração"
    task add_mining_types: :environment do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
        ]

     mining_types.each do |mining_type|
       MiningType.find_or_create_by!(mining_type)
    end
  end
   

 
 end

class CommandLineInterface

    def run
        system("clear")
        welcome = $prompt.select("Welcome to...  THE ELDERLY SCROLLS!") do |menu|
            menu.choice 'Start'
            menu.choice 'Exit'
        end
            if welcome == 'Start'
                greet
            else welcome == 'Exit'
                abort("Game Over, Mwahahaha!!!")
            end
    end

    def greet
        greeting = "Hey, you! You're finally awake... You must have passed out from the Bennies the nurse gave you, what is your name? 
        
        Choose from these:"
        player_names = Player.all.collect{ | player | player.name }
        name = $prompt.select(greeting, player_names)
        @player = Player.all.find{ | player | player.name == name }
        puts "You seem... social, go talk to someone #{name}!"
        pick_npc
    end
    
    def pick_npc
        start = "Go on, don't be shy now..."
        npc_names = Npc.all.collect{ | npc | npc.name }
        choose = $prompt.select(start, npc_names) 
            if choose == 'Eagle-Eye Dan'
                dan
            elsif choose == 'Old-Dragon Slayer Phillip'
                phillip 
            elsif choose == 'Drooling Dave'
                dave
            end
    end

    def dan
        npc_speech = Npc.all.collect{ | npc | npc.speech }
        npc_quests = Quest.all.collect{ | quest | quest.name }
        quest_reward = Quest.all.collect{ | quest | quest.quest_reward }
        choose = $prompt.select(npc_speech[0], npc_quests[0..2])
        quest = Quest.all.find{ | quest | quest.name == choose }
            if choose == npc_quests[0]
                puts "Good choice old-top! Complete it and you'll get the #{quest_reward[0]}"
                add_quest(quest)
            elsif choose == npc_quests[1]
                puts "Ahh yes, this one. Complete it and you'll get the #{quest_reward[1]}"
                add_quest(quest)
            elsif choose == npc_quests[2]
                puts "Ohh, you are gonna like this one, complete it and you'll get the #{quest_reward[2]}"
                add_quest(quest)
            end
    end

    def phillip
        npc_speech = Npc.all.collect{ | npc | npc.speech }
        npc_quests = Quest.all.collect{ | quest | quest.name }
        quest_reward = Quest.all.collect{ | quest | quest.quest_reward }
        choose = $prompt.select(npc_speech[1], npc_quests[3..5])
        quest = Quest.all.find{ | quest | quest.name == choose }
            if choose == npc_quests[3]
                puts "Good choice old-top! Complete it and you'll get the #{quest_reward[3]}"
                add_quest(quest)
            elsif choose == npc_quests[4]
                puts "Ahh yes, this one. Complete it and you'll get the #{quest_reward[4]}"
                add_quest(quest)
            elsif choose == npc_quests[5]
                puts "Ohh, you are gonna like this one, complete it and you'll get the #{quest_reward[5]}"
                add_quest(quest)
            end
    end

    def dave
        npc_speech = Npc.all.collect{ | npc | npc.speech }
        npc_quests = Quest.all.collect{ | quest | quest.name }
        quest_reward = Quest.all.collect{ | quest | quest.quest_reward }
        choose = $prompt.select(npc_speech[2], npc_quests[6..8])
        quest = Quest.all.find{ | quest | quest.name == choose }
            if choose == npc_quests[6]
                puts "Good choice old-top! Complete it and you'll get the #{quest_reward[6]}"
                add_quest(quest)
            elsif choose == npc_quests[7]
                puts "Ahh yes, this one. Complete it and you'll get the #{quest_reward[7]}"
                add_quest(quest)
            elsif choose == npc_quests[8]
                puts "Ohh, you are gonna like this one, complete it and you'll get the #{quest_reward[8]}"
                add_quest(quest)

            end
    end
    
    
    def add_quest(quest)
        journal = Player.all.collect{ | player | player.quest_log }
        choose = $prompt.select("Go ahead and add the quest to your Quest Log. If you dont do it you WILL forget!") do |menu|
            menu.choice 'Add to Quest Log'
            menu.choice 'Speak to Another'
            menu.choice 'Exit'
        end
            if choose == 'Add to Quest Log'
                puts "Quest has been added"
                quest.update(player_id: @player.id)
                player_menu
            elsif choose == 'Speak to Another'
                puts "A social butterfly I see!"
                pick_npc
            elsif choose == 'Exit'
                abort("Game Over, Mwahahaha!!!")
            end
    end
    
    def player_menu
        choose = $prompt.select("Please choose from the following: ") do | menu |
            menu.choice 'Check Quest Log'
            menu.choice 'Talk to Quest Giver'
            menu.choice 'Develop Feelings'
            menu.choice 'Exit'
        end
            if choose == 'Check Quest Log'
                puts "* You open up your journal of quests *"
                quest_log
            elsif choose == 'Talk to Quest Giver'
                puts "A social butterfly I see!"
                pick_npc
            elsif choose == 'Develop Feelings'
                puts "I think, I'm starting to love you..."
                player_menu
            else choose == 'Exit'
                abort("Game Over, Mwahahaha!!!")
            end
        
    end
    
    def get_player_quests
        @player.quests
    end

    def quest_log
        quests = get_player_quests
        chosen = $prompt.select("These are all your quests. What quest would you like to complete", quests.collect{ | quest | quest.name }) do | menu |
            menu.choice 'Return to Player Menu'
            menu.choice 'Exit'
        end 
            quest = @player.quests.find{ | quest | quest.name == chosen }
            if chosen == 'Return to Player Menu'
                player_menu
            elsif chosen == 'Exit'
                abort("Game Over, Mwahahaha!!!")
            else 
                quest.update(player_id: nil)
                @player.quests.reload
            end
        player_menu
    end
end

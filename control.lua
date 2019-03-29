local function memory_of(player)
    if global.player_memory == nill then
        global.player_memory = {}
    end
    if global.player_memory[player.index] == nill then
        global.player_memory[player.index] = {
            held_item_name = nil,
            ignore_next = false
        }
    end
    return global.player_memory[player.index]
end

script.on_event(defines.events.on_player_cursor_stack_changed, function(event)
    local player = game.players[event.player_index]

    if memory_of(player).ignore_next then
        memory_of(player).ignore_next = false
        do
            return
        end
    end

    if player.cursor_stack ~= nil and player.cursor_stack.valid and player.cursor_stack.valid_for_read then
        memory_of(player).held_item_name = player.cursor_stack.name
    else
        player.cursor_ghost = memory_of(player).held_item_name
    end
end)

script.on_event("GhostInHand_clean-cursor", function(event)
    local player = game.players[event.player_index]

    memory_of(player).ignore_next = true
end)
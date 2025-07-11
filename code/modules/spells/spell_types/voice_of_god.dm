/obj/effect/proc_holder/spell/voice_of_god
	name = "Voice of God"
	desc = "Speak with an incredibly compelling voice, forcing listeners to obey your commands."
	charge_max = 1200 //variable
	cooldown_min = 0
	level_max = 1
	clothes_req = FALSE
	antimagic_allowed = TRUE
	action_icon = 'icons/mob/actions/actions_items.dmi'
	action_icon_state = "voice_of_god"
	var/command
	var/cooldown_mod = 1
	var/power_mod = 1
	var/list/spans = list("colossus","yell")
	var/speech_sound = 'sound/magic/clockwork/invoke_general.ogg'

/obj/effect/proc_holder/spell/voice_of_god/can_cast(mob/user = usr)
	if(!user.can_speak())
		to_chat(user, span_warning("You are unable to speak!"))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/voice_of_god/choose_targets(mob/user = usr)
	perform(user=user)
/obj/effect/proc_holder/spell/voice_of_god/perform(list/targets, recharge = 1, mob/user = usr)
	command = input(user, "Speak with the Voice of God", "Command")
	if(QDELETED(src) || QDELETED(user))
		return
	if(!command)
		revert_cast(user)
		return
	..()

/obj/effect/proc_holder/spell/voice_of_god/cast(list/targets, mob/user = usr)
	playsound(get_turf(user), speech_sound, 300, TRUE, 5)
	var/cooldown = voice_of_god(uppertext(command), user, spans, base_multiplier = power_mod)
	charge_max = (cooldown * cooldown_mod)

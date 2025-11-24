extends CanvasLayer

@onready var hp_bar = $Control/MarginContainer/VBoxContainer/HPBar
@onready var speed_label = $Control/MarginContainer/VBoxContainer/SpeedLabel
@onready var dmg_label = $Control/MarginContainer/VBoxContainer/DamageLabel

# We inject the dependency externally.
func setup_ui(player: PlayerController):
	# 1. Connect Health (Assuming HealthComponent has on_health_changed(current, max))
	if player.health:
		player.health.on_health_changed.connect(update_health)
		# Initialize
		update_health(player.health.current_health, player.health.max_health)
	
	# 2. Connect Movement Speed
	if player.movement:
		player.movement.on_speed_changed.connect(update_speed)
		# Initialize manual check
		update_speed(player.movement.speed)

	# 3. Connect Combat Stats
	if player.combat:
		player.combat.on_damage_multiplier_changed.connect(update_dmg)
		update_dmg(player.combat.damage_multiplier)

func update_health(current, max_hp):
	hp_bar.max_value = max_hp
	hp_bar.value = current

func update_speed(new_speed):
	speed_label.text = "Speed: %.1f" % new_speed

func update_dmg(new_mult):
	dmg_label.text = "Dmg Mult: x%.1f" % new_mult

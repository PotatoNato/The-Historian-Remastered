extends Control
#ENEMYTYPE ONREADY
onready var Spaniard=preload("res://Scenes/Enemies/Spaniard_Enemy.tscn")
onready var SpaniardBoss=preload("res://Scenes/Bosses/Spaniard_Boss.tscn")
onready var American=preload("res://Scenes/Enemies/American_Enemy.tscn")
onready var AmericanBoss=preload("res://Scenes/Bosses/American_Boss.tscn")
onready var Japan=preload("res://Scenes/Enemies/Japanese_Enemy.tscn")
onready var JapanBoss=preload("res://Scenes/Bosses/Japanese_Boss.tscn")
onready var Skillup=preload("res://Scenes/UI_Scenes/Skill_Up.tscn")
#PLAYER/ENEMY ONREADY
onready var Player=$PlayerSpawn/Player
var Enemy=null
#ANIMATION ONREADY
onready var PlayerAnim=$PlayerSpawn/Player/Sprite/Animate
var EnemyAnim=null
#VARIABLES
var Attack1="Attack"
var Attack2
var Attack3
var QnA=null
var num
func _ready():
	set_process_input(true)
	set_process(true)
	var instance
	if Ctrl.Stage==1 and Ctrl.isBoss==true:
		instance=SpaniardBoss.instance()
		$EnemySpawn.add_child(instance)
		$BG.texture=load("res://Sprites/BGandMisc/SpanishBG.png")
		QnA=$QnASpain
	elif Ctrl.Stage==1 and Ctrl.isBoss!=true:
		instance=Spaniard.instance()
		$EnemySpawn.add_child(instance)
		QnA=$QnASpain
		Attack1="GunAttack"
		Attack2="SwordAttack"
		Attack3="HalberdAttack"
	if Ctrl.Stage==2 and Ctrl.isBoss==true:
		instance=AmericanBoss.instance()
		$EnemySpawn.add_child(instance)
		QnA=$QnAAmerica
	elif Ctrl.Stage==2 and Ctrl.isBoss!=true:
		instance=American.instance()
		$EnemySpawn.add_child(instance)
		QnA=$QnAAmerica
		Attack1="BARAttack"
		Attack2="M1Attack"
		Attack3="BazookaAttack"
	if Ctrl.Stage==3 and Ctrl.isBoss==true:
		instance=JapanBoss.instance()
		$EnemySpawn.add_child(instance)
		QnA=$QnASpain
	elif Ctrl.Stage==3 and Ctrl.isBoss!=true:
		instance=Japan.instance()
		$EnemySpawn.add_child(instance)
		QnA=$QnAJapan
		Attack1="SpearAttack"
		Attack2="SaiAttack"
		Attack3="CrossbowAttack"
	Enemy=instance
	EnemyAnim=Enemy.get_node("Sprite/Animate")
	answerlocation()
	QnA.rand()
func answerlocation():
	$QPanel/Question.set_text(QnA.questions())
	randomize()
	num=randi()%4
	if num==0:
		$Button1.connect("pressed",Player,"attack")
		$Button1/Answer1.set_text(QnA.answers())
		$Button2/Answer2.set_text(QnA.wrong1())
		$Button3/Answer3.set_text(QnA.wrong2())
		$Button4/Answer4.set_text(QnA.wrong3())
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	else:
		$Button1.connect("pressed",Enemy,"attack",[Player])
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	if num==1:
		$Button2.connect("pressed",Player,"attack")
		$Button2/Answer2.set_text(QnA.answers())
		$Button1/Answer1.set_text(QnA.wrong1())
		$Button3/Answer3.set_text(QnA.wrong2())
		$Button4/Answer4.set_text(QnA.wrong3())
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	else:
		$Button2.connect("pressed",Enemy,"attack",[Player])
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	if num==2:
		$Button3.connect("pressed",Player,"attack")
		$Button3/Answer3.set_text(QnA.answers())
		$Button1/Answer1.set_text(QnA.wrong1())
		$Button2/Answer2.set_text(QnA.wrong2())
		$Button4/Answer4.set_text(QnA.wrong3())
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	else:
		$Button3.connect("pressed",Enemy,"attack",[Player])
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	if num==3:
		$Button4.connect("pressed",Player,"attack")
		$Button4/Answer4.set_text(QnA.answers())
		$Button1/Answer1.set_text(QnA.wrong1())
		$Button2/Answer2.set_text(QnA.wrong2())
		$Button3/Answer3.set_text(QnA.wrong3())
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	else:
		$Button4.connect("pressed",Enemy,"attack",[Player])
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	print(num)
func _input(event):
	if event.is_action("return") && event.is_pressed() && !event.is_echo():
		get_tree().change_scene("res://Scenes/Stage_Level_Select/Level.tscn")
		#Button1
		$Button1.disconnect("pressed",Player,"attack")
		$Button1.disconnect("pressed",Enemy,"attack")
	#Button2
		$Button2.disconnect("pressed",Player,"attack")
		$Button2.disconnect("pressed",Enemy,"attack")
	#Button3
		$Button3.disconnect("pressed",Player,"attack")
		$Button3.disconnect("pressed",Enemy,"attack")
	#Button4
		$Button4.disconnect("pressed",Player,"attack")
		$Button4.disconnect("pressed",Enemy,"attack")
func _process(delta):
	if EnemyAnim.current_animation=="Transform" or PlayerAnim.current_animation=="Attack" or EnemyAnim.current_animation==Attack1 or EnemyAnim.current_animation==Attack2 or EnemyAnim.current_animation==Attack3 or PlayerAnim.current_animation=="Hurt" or EnemyAnim.current_animation=="Hurt":
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	else:
		$Button1.disabled=false
		$Button2.disabled=false
		$Button3.disabled=false
		$Button4.disabled=false
	if Player.HP==0 or Enemy.HP==0:
		$Button1.disabled=true
		$Button2.disabled=true
		$Button3.disabled=true
		$Button4.disabled=true
	Dead()
func Dead():
	var instance=null
	if Player.dead==true:
		get_tree().change_scene("res://Scenes/Stage_Level_Select/Level.tscn")
#BOSS DEFEATED
	if Enemy.dead==true and Ctrl.isBoss==true:
		Ctrl.Level=1
		instance=Skillup.instance()
		add_child(instance)
		if Ctrl.Stage==1 and Ctrl.Boss==1:
			Ctrl.Stage1Cleared=true
			Ctrl.Level4Cleared=true
		elif Ctrl.Stage==2 and Ctrl.Boss==2:
			Ctrl.Stage2Cleared=true
			Ctrl.Level4Cleared=true
		elif Ctrl.Stage==3 and Ctrl.Boss==3:
			Ctrl.Stage3Cleared=true
			Ctrl.Level4Cleared=true
		if instance!=null:
			set_process(false)
#ENEMY DEFEATED
	elif Enemy.dead==true and Ctrl.isBoss!=true:
		if Ctrl.Level1Cleared!=true and Ctrl.Phase==1:
			instance=Skillup.instance()
			add_child(instance)
			Ctrl.Done=false
		elif Ctrl.Level2Cleared!=true and Ctrl.Phase==2:
			instance=Skillup.instance()
			add_child(instance)
			Ctrl.Done=false
		elif Ctrl.Level3Cleared!=true and Ctrl.Phase==3:
			instance=Skillup.instance()
			add_child(instance)
			Ctrl.Done=false
		elif Ctrl.Done==true:
			get_tree().change_scene("res://Scenes/Stage_Level_Select/Level.tscn")
		if Ctrl.Level==1 and Ctrl.Phase==1:
			Ctrl.Level1Cleared=true
			Ctrl.Level=2
		elif Ctrl.Level==2 and Ctrl.Phase==2:
			Ctrl.Level2Cleared=true
			Ctrl.Level=3
		elif Ctrl.Level==3 and Ctrl.Phase==3:
			Ctrl.Level3Cleared=true
			Ctrl.Level=4
		if instance!=null:
			set_process(false)
func _on_Button1_pressed():
	disconnectAttackSignals()
	answerlocation()
	QnA.rand()
func _on_Button2_pressed():
	disconnectAttackSignals()
	answerlocation()
	QnA.rand()
func _on_Button3_pressed():
	disconnectAttackSignals()
	answerlocation()
	QnA.rand()
func _on_Button4_pressed():
	disconnectAttackSignals()
	answerlocation()
	QnA.rand()
func disconnectAttackSignals():
#Button1
	$Button1.disconnect("pressed",Player,"attack")
	$Button1.disconnect("pressed",Enemy,"attack")
#Button2
	$Button2.disconnect("pressed",Player,"attack")
	$Button2.disconnect("pressed",Enemy,"attack")
#Button3
	$Button3.disconnect("pressed",Player,"attack")
	$Button3.disconnect("pressed",Enemy,"attack")
#Button4
	$Button4.disconnect("pressed",Player,"attack")
	$Button4.disconnect("pressed",Enemy,"attack")
func _on_Button_pressed():
	Enemy.HP=0
	Player.attack()


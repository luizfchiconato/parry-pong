extends Control

var rng = RandomNumberGenerator.new()

const dedo_do_meio: String = " ……..…../´¯/)……….. (\\¯`\\\\ \n" \
+ "…………/….//……….. …\\\\….\\ \n" \
+ "………../….//………… ….\\\\….\\ \n" \
+ "…../´¯/…./´¯\\………../¯ `\\….\\¯`\\ \n" \
+ ".././…/…./…./.|_……_| .\\….\\….\\…\\.\\.. \n" \
+ "(.(….(….(…./.)..)..(..(. \\….)….)….).) \n" \
+ ".\\…………….\\/…/….\\. ..\\/……………./ \n" \
+ "..\\…………….. /……..\\……………..…/ \n" \
+ "….\\…………..(………. ..)……………./"

const palhaco: String = "🤡ÅŤÅQŮĘ ĐØ§ PÅĽHÅÇØ§ ĽØĶØ🤡    AGORA É NOIS QUE MANDA NESSA PORRA \n" \
+ "☣☣☣👿 \n" \
+ "🤡SAIAM DO GINÁSIO 🤡  \n" \
+ " \n" \
+ "COMEÇOU O ATAQUE 🤡🤡🤡 \n" \
+ " \n" \
+ "HÁ! HÁ! HÁ! HÁ! HÁ!  \n" \
+ " \n" \
+ "🤡🤡🤡🤡🤡🤡 \n"

const shanub: String = "  **********************||\\ \n " \
+ "|SHANUB.ENCOMENDAS    |||**\\__ \n " \
+ "|_____________________|||___|_) \n " \
+ "!(@)'(@)*******(@)'(@)*****(@)[ \n "

const cinco_vezes: String = "Você já se fudeu 5 vezes nesse ginásio. Agora vou me ausentar pois tenho reunião. Infelizmente sou um homem muito dedicado no trabalho e isso me faz ser uma pessoa solicitada e ocupada"
const dez_vezes: String = "Voltando aqui pra falar: Você já se fudeu 10 vezes nesse ginásio"
const quinze_vezes: String = "Meu Deus você já se fudeu [font_size=50]15[/font_size] vezes nesse ginásio. Inacreditável"
const recorde_vezes: String = "Opa, voltei aqui só pra avisar: você já se fudeu [x] vezes nesse ginásio. É um recorde! Parabéns pela única conquista que você vai receber na sua vida"
const recordissimo_vezes: String = "Você já se fudeu [x] vezes nesse ginásio. E você continua destruindo absolutamente o recorde. Quem diria que você ia se tornar especial em alguma coisa"

const MENSAGENS: Array = [
	"Você é fraco e não vai resistir ao inverno",
	"saidfhnadojgiasdgnIUSAHGFIASDGS9ODGFHJSDA9UGASJGKOAS´DGAS",
	"KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK",
	dedo_do_meio,
	"Mas bah tu é um baita dum chinelão mesmo",
	"Você devia desistir. No geral",
	"Liguei para sua mãe e ela disse que preferia não ter criado um filho. E que você é adotado",
	"Viu, só te avisar que psicografamos uma carta do seu pai. Ele falou que o inferno é menos pior do que parece",
	"Você é menor que a bola e ela ainda consegue te acertar",
	"Ah sei lá pensa você agora em uma ofensa aí. do jeito que você se odeia você vai pensar em uma rapidinho",
	"Tá de corpo mole é?",
	 "Levanta essa bunda do chão e tenta de novo",
	 "Você gosta da Júlia, né? O Lauro tá ficando com ela. E ela falou que você é estranho",
	"Já te falaram que você anda rebolando? Você devia andar mais reto e de forma menos estranha",
	"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
	"só regresso irmão, muitos vao te derrubar mas, aconteça oq acontecer, não levante. te admiro pois vc começou do zero e continuou la, te criticar é facil, difícil é elogiar. tudo deles nada nosso 👊🏻🔥",
	"Eu vou deixar registrado aqui pra você, seu bosta. Seu obtuso. Seu ser maldito. Que tem gente aqui nesse grupo que tá há anos na UFRGS que tá se fudendo, entendeu. Que quer se formar de uma vez, entendeu. Isso aqui é Semântica Formal. É uma cadeira do quinto semestre, que é dum semestre que tem mais cadeiras obrigatórias nessa merda de curso, no caso, a ciência da computação. Imagino então o que que o pessoal da engenharia passa, tá. Mas só vou te dizer o seguinte: a gurizada aqui se fudendo no EAD aqui é uma bosta, sabe, é uma merda. As pessoas querendo tocar a vida, se formar, conseguir um emprego? Tentando dar um jeito de conciliar os estudos. E você. Seu bosta. Seu lixo. Em vez de não ajudar... não quer ajudar, cara. Fica na tua. Entendeu? Faz os teus trabalhos sozinho, se tu é fodão. Se tu é pica das galáxias. Se tu vai ser laureado, seu merda.",
	"Curse of RA 𓀀 𓀁 𓀂 𓀃 𓀄 𓀅 𓀆 𓀇 𓀈 𓀉 𓀊 𓀋 𓀌 𓀍 𓀎 𓀏 𓀐 𓀑 𓀒 𓀓 𓀔 𓀕 𓀖 𓀗 𓀘 𓀙 𓀚 𓀛 𓀜 𓀝 𓀞 𓀟 𓀠 𓀡 𓀢 𓀣 𓀤 𓀥 𓀦 𓀧 𓀨 𓀩 𓀪 𓀫 𓀬 𓀭 𓀮 𓀯 𓀰 𓀱 𓀲 𓀳 𓀴 𓀵 𓀶 𓀷 𓀸 𓀹 𓀺 𓀻 𓀼 𓀽 𓀾 𓀿 𓁀 𓁁 𓁂 𓁃 𓁄 𓁅 𓁆 𓁇 𓁈 𓁉 𓁊 𓁋 𓁌 𓁍 𓁎 𓁏 𓁐 𓁑 𓀄 𓀅",
	"Escalador de calçada",
	"Arquiteto de Lego",
	"Escultor de suspiro",
	"Goleiro de pebolim",
	"Tampinha",
	"Operador de zíper",
	"Mordedor de canela",
	"Você é o menor dos meus problemas",
	"Mão de alface",
	"Raquete furada",
	palhaco,
	shanub,
	"Deus está insatisfeito com a sua existência e você deve se preparar para uma eternidade em sofrimento",
	"Lolzeiro",
	"Viu, Jones me contou uma coisa depois da aula de química de vocês. Serião que você ainda é BV?",
	"🚨🚨 URGENTE!!!🚨🚨 🚨🚨FOI DETECTADO O PRIMEIRO CASO DA DOENÇA DO PASSARO 🦅🦅🦅 NA ESCOLA CAIXEIRO VIAJANTE 🚨🚨 PASSARO O PAU NO ALUNO PEDRO",
	"Oi meu nome é Samara, tenho 14 anos (Teria se estivesse viva), morri aos 13 em Cascavel-PR. Eu andava de bicicleta Quando não pude desviar de um arame farpado. O pior foi que o dono do lote não quis me ajudar, riu bastante mim após agonizar por 2 horas enroscada no arame eu faleci, através dessa mensagem eu peço que façam com que eu possa descançar em paz. Envie isso para 20 comunidades e minha alma estara sendo salva por você e pelos outros 20 que receberão. Caso não repasse essa mensagem vou visitar-lhe hoje a noite assim vc poderá conhecer o tal arame bem de pertinho. Dia 15 de Julho Mariana resolveu rir dessa mensagem, uma noite depois ela sumiu sem deixar vestigios. O mesmo aconteceu com Kare dia 18 de Outubro. Não Quebre essa corrente por favor, a não ser que queira sentir a minha presença",
	"O Naruto pode ser um pouco duro às vezes, talvez você não saiba disso, mas o Naruto também cresceu sem pai. Na verdade ele nunca conheceu nenhum de seus pais, e nunca teve nenhum amigo em nossa aldeia. Mesmo assim eu nunca vi ele chorar, ficar zangado ou se dar por vencido, ele está sempre disposto a melhorar, ele quer ser respeitado, é o sonho dele e o Naruto daria a vida por isso sem hesitar. Meu palpite é que ele se cansou de chorar e decidiu fazer alguma coisa a respeito!",
	"Eu entendo, fica difícil mesmo ver a bola quando você tem que olhar pra cima pra enxergar. Pintorzinho de rodapé",
	"Cabeça de bolota cabeça de barril cabeça de abóbora cabeça de fuzil é o cabeção de plástico cabeça de Max Steel",
	"Cu baixo",
	"Tamburete",
	"Anão de jardim",
	"Dunga",
	"Toco de amarrar bode",
	"Bebê reborn",
	"Hipista de cachorro",
	"Cabeça de desequilíbrio",
	"FALAAAAAAAAAAAAAAAAAAAA DERICK AHAHAHAHAHAHAHAA",
	"AHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAAAHAHAHAHAHAHAHAA"
]

const MENSAGENS_CHUMBO: Array = [
	"Caiu no conto da bola de chumbo né otário",
	"Pqp caiu de novo"
]

const MENSAGENS_BOLICHE: Array = [
	"STRIKE",
	"Bom que a bola de boliche ainda é mais macia que esse cabeção de bigorna"
]

const MENSAGENS_TINTA: Array = [
	"fdsifuhsrBGDASUIGHADSGA ESCORREGOU QUE NEM UM MERDA",
	"Pqp caiu de novo",
	"É difícil mesmo manter o equilíbrio com essa cabeça de playmobil"
]

const SPEED = 12

var chosen_text : String = ""
var visible_characters = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var index = rng.randf_range(0, MENSAGENS.size() - 1)
	chosen_text = MENSAGENS[index]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible_characters += ceil(SPEED * delta)
	if (visible_characters > chosen_text.length()):
		visible_characters = chosen_text.length()
	$CanvasLayer/RichTextLabel.text = "[font_size=25]" + chosen_text.substr(0, visible_characters) + "[/font_size]"
	
	if(Input.is_action_just_pressed("Enter") or Input.is_action_just_pressed("Esc")):
		Global.game_controller.reload_current_2d_scene()
		
	if Input.is_action_just_pressed("Restart"):
		Global.game_controller.reload_current_2d_scene()

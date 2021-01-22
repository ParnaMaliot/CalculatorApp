
import UIKit
import AVFoundation

enum Test {
    case one 
    case two
}
enum Operation: String {
    case add = "+"
    case substruct = "-"
    case multiply = "*"
    case devide = "/"
    case equal = "="
    case empty = " "
}

class ViewController: UIViewController {

    @IBOutlet weak var lblDisplay: UILabel!
    
    var player: AVAudioPlayer?

    // Vo ovaa promentliva ke go cuvame brojot sto go odbira userot pred i po odbiranjeto na operacija
    var runningNumber = ""
    
    //Po odbiranje na operacija ovde ke go smestime brojot sto prethodno bil vo runningNumber. I po prikazuvanje na rezultatot na ekran.
    var leftValStr = ""
    
    //Po odbiranjeto na znak vo ovaa promenliva ke go cuvame vtoriot odbran broj (left + right = result)
    var rightValStr = ""
    
    //Vo ovaa promenliva ke ja cuvame odbranata operacija
    var currentOperation: Operation = .empty
    
    //Vo ovaa promenliva ke go cuvame krajniot rezultat
    var result = ""
    
    deinit {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Settirame da se prikaze "0" pri start na applikacijata
        lblDisplay.text = "0"
        
        lblDisplay.layer.cornerRadius = 10
        
        
        self.setupLabel()
        preparePlayer()
    }

    func setupLabel() {
        lblDisplay.font = UIFont(name: "Minecraft", size: 25)!
        lblDisplay.textColor = .black
    }
    
    func preparePlayer() {
        guard let url = Bundle.main.url(forResource: "btn", withExtension: "wav") else { 
            return
        }
            player = try! AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
    }
    
    @IBAction func equal(_ sender: UIButton) {
        calculateOperation(operation: .equal)
    }
    
    
    //Ovaa funkcija ja povikuvaat site kopcinja so cifra
    @IBAction func onClick(_ sender: UIButton) {
        //Ja zemame stisnatata brojka od "tag"-ot na kopceto
        let number = sender.tag
        
        //Proveruvame dali prethodno imame nekoja cifra veke stisnata
        if runningNumber != "" {
            //Dokolku imame veke vpisana cifra, na nea kako string ke ja zalepime novata kliknata cifra.
            runningNumber = runningNumber + "\(number)" 
        } else {
            
            //Dokolku nemame ke ja zacuvame tuka prvata kliknata cifra.
            runningNumber = "\(number)"
        }
        
        //Samo ja prikazuvame na ekran brojkata spoena (posebnite cifi)
        lblDisplay.text = runningNumber
    }
    
    @IBAction func add(_ sender: UIButton) {
        calculateOperation(operation: .add)
    }
    
    @IBAction func substruct(_ sender: UIButton) {
        calculateOperation(operation: .substruct)
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        calculateOperation(operation: .multiply)
    }
    
    @IBAction func devide(_ sender: UIButton) {
        calculateOperation(operation: .devide)
    }
    
    //Vo ovaa funkcija ke go pravime realno presmetuvanjeto. Site kopcinja za operacii ke ja povikuvaat ovaa funkcija so soodvetnata operacija.
    func calculateOperation(operation: Operation) {
        player?.play()
        
        //Proveruvame dali korisnikot ne obral operacija prethono (odnosno na prvoto biranje na operacija "currentOperation" ke bide "empty")
        if currentOperation == .empty {
            //Ova se povikuva sekogash koga prv pat se klikna na operacija
            
            //Ja zacuvuvame odbranata brojka vo "leftValStr"
            leftValStr = runningNumber
    
            //Go briseme "cachiraniot" broj
            runningNumber = ""
            
            //Ja setirame momentalna operacija da bide odbranata operacija od korisnikot
            currentOperation = operation
        } else {
            //Dokolku korisniot odbral veke operacija (znaci "leftValStr" veke postoi)
            if runningNumber != "" {
                //Po odbiranjeto na 2rata brojka "runningNumber" ke ja drzi nejzinata vrednost
                
                //Setirame "rightValStr" odnosno desnata strana na ravenstvoto da bide novata brojka
                rightValStr = runningNumber
                
                //Go briseme "cachiraniot" broj
                runningNumber = ""
                
                
                //Ja proveruvame operacija i vrsime soodvetna matematika (left "operacija" right = result)
                if currentOperation == .add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == .multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == .substruct {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == .devide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                
                //Stavame sega left da bide rezultatot bidejki useriot moze da prodolzi pak da obere operacija i rezultatot go gledame kako leva strana od ravenstvo
                leftValStr = result
                
                //Setirame rezultat na ekran
                lblDisplay.text = result
            }
            
            //Ja cuvame novata odbrana operacija kako momentalna
            currentOperation = operation
        }
    }
}


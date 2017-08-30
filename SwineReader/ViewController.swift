import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var usernameTextField: UITextField!
  @IBOutlet var debugTextView: UITextView!
  
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    usernameTextField.becomeFirstResponder()
  }
  
  @IBAction func actionCreateUser() {
    guard let username = usernameTextField.text, username != "" else {
      self.showDebug(text: "WARNING: username cannot be empty")
      return
    }
    
    let newUser = DIManager.initUser(username: username)
    newUser.create { error in
      self.showDebug(text: error == nil ? "user create successfully" : "WARNING: user create failed: \(error!.localizedDescription)")
      self.user = newUser
      DispatchQueue.main.async {
        self.usernameTextField.text = ""
      }
    }
  }
  
  @IBAction func actionShowUserDetail() {
    self.showDebug(text: user?.description ?? "WARNING: no user created yet")
  }
  
  func showDebug(text: String) {
    debugTextView.text = (debugTextView.text ?? "") + "\n" + text
    var y = debugTextView.contentSize.height - debugTextView.frame.size.height
    y = y < 0 ? 0 : y
    debugTextView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

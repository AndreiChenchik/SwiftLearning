//
//  ViewController.swift
//  Project25
//
//  Created by Andrei Chenchik on 4/6/21.
//
import MultipeerConnectivity
import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {
    func userDisconnected(with name: String) {
        let disconnectedAC = UIAlertController(title: "User disconnected", message: "Someone with name \(name) left the network.", preferredStyle: .alert)
        disconnectedAC.addAction(UIAlertAction(title: "OK", style: .default))
        present(disconnectedAC, animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .notConnected:
            print("Not connected: \(peerID.displayName)")
            userDisconnected(with: peerID.displayName)
        @unknown default:
            print("Unknown: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            [weak self] in
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
                return
            }
            
            let message = String(decoding: data, as: UTF8.self)
            let messageAC = UIAlertController(title: "From \(peerID.displayName)", message: message, preferredStyle: .alert)
            messageAC.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(messageAC, animated: true)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    
    
    var images = [UIImage]()
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Selfie Share"
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture)),
            UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: #selector(sendMessage))
        ]
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt)),
            UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showNetworkInfo))
        ]
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
        
    }
    
    @objc func showNetworkInfo() {
        let infoAC: UIAlertController
        
        if let mcSession = mcSession {
            var peers = [String]()
            for peer in mcSession.connectedPeers {
                peers.append(peer.displayName)
            }
            infoAC = UIAlertController(title: "Network Participants", message: peers.joined(separator: "\n"), preferredStyle: .alert)
        } else {
            infoAC = UIAlertController(title: "Network is not established", message: nil, preferredStyle: .alert)
        }
        
        infoAC.addAction(UIAlertAction(title: "OK", style: .default))

        present(infoAC, animated: true)
    }
    
    @objc func sendMessage() {
        let messageAC = UIAlertController(title: "Type your message", message: nil, preferredStyle: .alert)
        messageAC.addTextField()
        messageAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        messageAC.addAction(UIAlertAction(title: "Send", style: .default, handler: { [weak self, weak messageAC] _ in
            guard let text = messageAC?.textFields?[0].text else { fatalError("Can't get text from field") }
            let data = Data(text.utf8)
            self?.sendDataToNetwork(data)
        }))
        
        present(messageAC, animated: true)
    }
    
    func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
        let startedAC = UIAlertController(title: "Network created", message: nil, preferredStyle: .alert)
        startedAC.addAction(UIAlertAction(title: "Nice", style: .default))
        present(startedAC, animated: true)
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func sendDataToNetwork(_ data: Data) {
        guard let mcSession = mcSession else { return }
        if mcSession.connectedPeers.count > 0 {
            
            do {
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        if let imageData = image.pngData() {
            sendDataToNetwork(imageData)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
}


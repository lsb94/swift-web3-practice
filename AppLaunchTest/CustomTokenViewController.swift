//
//  CustomTokenViewController.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/18.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3

class CustomTokenViewController: UIViewController {

    let web3 = MyWeb3.shared.web3
    let myAddress = UserDefaults.standard.value(forKey: "address") as! String
    
    @IBOutlet weak var textEthBalance: UILabel!
    @IBOutlet weak var collectionViewTokens: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        self.navigationController?.viewControllers.removeFirst(1)
        
        self.navigationItem.title = "MyWallet"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "MyQR", style: .plain, target: self, action: #selector(buttonMyQR)), animated: true)
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(buttonAddToken)), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ETH 부분 데이터 로딩
        let address = self.myAddress
        print(address)
        do {
            let etherAddress = try EthereumAddress.init(hex: address, eip55: true)
                web3.eth.getBalance(address: etherAddress, block: .latest) { response in
                    let balanceAsWei = response.result?.quantity
                    let balanceAsEth = Double(balanceAsWei!) / pow(10, 18)
                    DispatchQueue.main.async {
                        self.textEthBalance.text = String(balanceAsEth)
                    }
                }
        } catch {print(error)}
        
        //Tokens collection 부분 데이터 로딩
        let uinib = UINib(nibName: "CustomTokenCollectionViewCell", bundle: nil)
        collectionViewTokens.register(uinib, forCellWithReuseIdentifier: "CollectionCellToken")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc private func buttonMyQR() {
        print("QR")
        let myAddress = self.myAddress
        guard let qrImage = MyQRGenerator.generateQRCode(from: myAddress) else {
            return
        }
        let qrView = UIImageView(frame: CGRect(x: 35, y: -220, width: 200, height: 200))
        qrView.image = qrImage
        
        let alert = UIAlertController.init(title: "QR로 내 지갑주소 보기", message: myAddress, preferredStyle: .alert)
        alert.view.addSubview(qrView)
        alert.addAction(UIAlertAction.init(title: "확인", style: .cancel, handler: nil))
        
        MyAlertOnTop.shared.getTopViewController()?.present(alert, animated: true, completion: nil)
    }
    @objc private func buttonAddToken() {
        print("add")
    }
}

extension CustomTokenViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TokenDummy.dummyTokenList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomTokenCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellToken", for: indexPath) as! CustomTokenCollectionViewCell
        let target = TokenDummy.dummyTokenList[indexPath.row]

        cell.textTokenBalacne.text = target.balanceDummy
        cell.textTokenSymbol.text = target.symbolDummy

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/4)
    }
}

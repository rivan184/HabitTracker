//
//  InfoViewController.swift
//  HabitTrackerApp
//
//  Created by Maria Jeffina on 03/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var imgMainInfo: UIImageView!
    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var txtMainContent: UITextView!
    @IBOutlet weak var txtCredit: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Collect and show data
        imgMainInfo.layer.cornerRadius = 10
        imgMainInfo.image = UIImage(named : "testImage")
        txtTitle.text = "Symtoms"
        txtMainContent.text = "Presiden Joko Widodo (Jokowi) hari ini kembali mengumumkan langkah yang diambil pemerintah untuk menangani dampak yang ditimbulkan dari wabah COVID-19. Salah satunya adalah membebaskan kewajiban pembayaran tarif listrik, alias gratis. Jokowi mengatakan, pemerintah menetapkan pelanggan listrik di golongan 450 VA akan digratiskan. Jumlah pelanggan listrik ini diperkirakan mencapai 24 juta pelanggan. Tentang tarif listrik, perlu saya sampaikan untuk pelanggan listrik 450 VA yang jumlahnya sekitar 24 juta pelanggan akan digratiskan, tuturnya dalam konferensi pers melalui virtual, Selasa (30/3/2020).Presiden Joko Widodo (Jokowi) hari ini kembali mengumumkan langkah yang diambil pemerintah untuk menangani dampak yang ditimbulkan dari wabah COVID-19. Salah satunya adalah membebaskan kewajiban pembayaran tarif listrik, alias gratis. Jokowi mengatakan, pemerintah menetapkan pelanggan listrik di golongan 450 VA akan digratiskan. Jumlah pelanggan listrik ini diperkirakan mencapai 24 juta pelanggan. Tentang tarif listrik, perlu saya sampaikan untuk pelanggan listrik 450 VA yang jumlahnya sekitar 24 juta pelanggan akan digratiskan, tuturnya dalam konferensi pers melalui virtual, Selasa (30/3/2020).Presiden Joko Widodo (Jokowi) hari ini kembali mengumumkan langkah yang diambil pemerintah untuk menangani dampak yang ditimbulkan dari wabah COVID-19. Salah satunya adalah membebaskan kewajiban pembayaran tarif listrik, alias gratis. Jokowi mengatakan, pemerintah menetapkan pelanggan listrik di golongan 450 VA akan digratiskan. Jumlah pelanggan listrik ini diperkirakan mencapai 24 juta pelanggan. Tentang tarif listrik, perlu saya sampaikan untuk pelanggan listrik 450 VA yang jumlahnya sekitar 24 juta pelanggan akan digratiskan, tuturnya dalam konferensi pers melalui virtual, Selasa (30/3/2020).Presiden Joko Widodo (Jokowi) hari ini kembali mengumumkan langkah yang diambil pemerintah untuk menangani dampak yang ditimbulkan dari wabah COVID-19. Salah satunya adalah membebaskan kewajiban pembayaran tarif listrik, alias gratis. Jokowi mengatakan, pemerintah menetapkan pelanggan listrik di golongan 450 VA akan digratiskan. Jumlah pelanggan listrik ini diperkirakan mencapai 24 juta pelanggan. Tentang tarif listrik, perlu saya sampaikan untuk pelanggan listrik 450 VA yang jumlahnya sekitar 24 juta pelanggan akan digratiskan, tuturnya dalam konferensi pers melalui virtual, Selasa (30/3/2020)"
        
        txtCredit.text = "Source : https://finance.detik.com/energi/d-4959835/jokowi-gratiskan-tagihan-listrik-3-bulan"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func exitView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("pressed")
    }
}

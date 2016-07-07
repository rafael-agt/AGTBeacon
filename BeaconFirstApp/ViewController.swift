//
//  ViewController.swift
//  BeaconFirstApp
//
//  Created by AGTechnologies Produtos Eletronicos Ltda. on 08/06/16.
//  Copyright © 2016 AGTechnologies Produtos Eletronicos Ltda. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate
{

    @IBAction func siteButton(sender: UIButton) {
        let url = NSURL(string: "http://www.agte.com.br")
        UIApplication.sharedApplication().openURL(url!)
        
    }
    
    @IBOutlet weak var siteButton: UIButton!
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    var locationManager: CLLocationManager!
    
    
    @IBOutlet weak var Logo: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.grayColor()
        siteButton.setTitle("", forState: .Normal)
    }
    
    func startScanning()
    {
        let uuid1 = NSUUID(UUIDString: "669A0C20-0008-969E-E211-9EB1E2F273D9")
        //let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "beacon")
        let beaconRegion1 = CLBeaconRegion(proximityUUID: uuid1!, major: 00, minor: 00, identifier: "Daniel's Beacon")
        
        //Usar um FOR no beaconRegion para mudar o minor em busca de mais de um beacon!!!!
        
        
        //let uuid2 = NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")
        //let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "beacon")
        //let beaconRegion2 = CLBeaconRegion(proximityUUID: uuid2!, major: 00, minor: 00, identifier: "AGT Beacon")
        
        locationManager.startMonitoringForRegion(beaconRegion1)
        locationManager.startRangingBeaconsInRegion(beaconRegion1)
        //locationManager.startMonitoringForRegion(beaconRegion2)
        //locationManager.startRangingBeaconsInRegion(beaconRegion2)
    }
    
    func updateDistance (distance:CLProximity)
    {
        UIView.animateWithDuration(1.5)
        { [unowned self] in
            switch distance
            {
            //case .Unknown:
                //self.view.backgroundColor = UIColor.grayColor()
                //self.distanceLabel.text = "Fora do Alcance"
            
            //case .Far:
                //self.view.backgroundColor = UIColor.blueColor()
                //self.distanceLabel.text = "Longe (+3 metros)"
                
            case .Near:
                self.view.backgroundColor = UIColor.cyanColor()
                self.distanceLabel.text = "AGT"
                self.Logo.image = UIImage(named: "Logo")
                self.siteButton.setTitle("SITE", forState: .Normal)
                
            case .Immediate:
                self.view.backgroundColor = UIColor.cyanColor()
                self.distanceLabel.text = "AGT"
                self.Logo.image = UIImage(named: "Logo")
                self.siteButton.setTitle("SITE", forState: .Normal)
                
                
            default:
                self.view.backgroundColor = UIColor.grayColor()
                self.distanceLabel.text = "Procurando Empresas"
                self.Logo.image = UIImage(named: "fivel")
                self.siteButton.setTitle("", forState: .Normal)
                
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
        if beacons.count > 0
        {
            let beacon = beacons.first! as CLBeacon
            updateDistance(beacon.proximity)
        }
        else
        {
            updateDistance(.Unknown)
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedAlways || status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self)
            {
                if CLLocationManager.isRangingAvailable()
                {
                   startScanning()
                }
            }
        }
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


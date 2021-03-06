import UIKit
import Vision


let modelURL = Bundle.main.url(forResource: "Inceptionv3", withExtension: "mlmodelc")!

guard let model = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) else {
    fatalError()
}

func createRequest(model: VNCoreMLModel) -> VNCoreMLRequest{
    return VNCoreMLRequest(model: model, completionHandler: { (req, err) in
        DispatchQueue.main.async(execute: {
            guard let results = req.results as? [VNClassificationObservation] else {
                fatalError("Error results")
            }
            print("\(results[0].confidence), \(results[0].identifier)")
            print("\(results[1].confidence), \(results[1].identifier)")
            print("\(results[2].confidence), \(results[2].identifier)")
            print()
        })
    })
}

let img1 = UIImage(named: "sample1.jpg")!
let img2 = UIImage(named: "sample2.jpg")!

let handler1 = VNImageRequestHandler(cgImage: img1.cgImage!, options: [:])
let request1 = createRequest(model: model)
try? handler1.perform([request1])

let handler2 = VNImageRequestHandler(cgImage: img2.cgImage!, options: [:])
let request2 = createRequest(model: model)
try? handler2.perform([request2])

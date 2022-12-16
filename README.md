# Veryable Challenge

![Simulator Screen Recording - iPhone 14 Pro - 2022-12-16 at 00 40 53](https://user-images.githubusercontent.com/47676921/208039441-31ba659e-1cfd-472f-aa81-84c223c62c17.gif)

# Architecture

> Clean Architecture + ReactorKit (MVVM + RxSwift)

<img width="800" alt="스크린샷 2022-12-16 오전 12 32 22" src="https://user-images.githubusercontent.com/47676921/208038264-0308c66b-a494-4335-828b-6edf88e4e623.png">

## Clean Architecture

Clean architecture is a software design philosophy that separates the elements of a design into ring levels.

<img width="800" alt="스크린샷 2022-12-16 오전 12 32 22" src="https://user-images.githubusercontent.com/47676921/208038648-adfb7ea9-8e56-4442-931e-32b27f0dcafd.png">

## ReactorKit

ReactorKit is a combination of Flux and Reactive Programming. The user actions and the view states are delivered to each layer via observable streams. These streams are unidirectional: the view can only emit actions and the reactor can only emit states.

<img width="800" alt="스크린샷 2022-12-16 오전 12 32 22" src="https://user-images.githubusercontent.com/47676921/208038465-5e9ac5f3-a71a-473e-9bbe-cb06be984ef2.png">

## Test

> Coverage: 78%

![스크린샷 2022-12-16 오전 12 53 28](https://user-images.githubusercontent.com/47676921/208040140-aa1c6b37-1ab7-4d5c-839f-6a39753f9e28.png)

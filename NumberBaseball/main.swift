import Foundation

let game = start()
game.main()

// 랜덤 수 생성 - 랜덤으로 지정된 값을 radonNumber에 추가, randomNumber에 추가된 값을 numbers에서 제거 (반복문)
func Random() -> [Int] {
    var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var randomNumber = [Int]()
    
    randomNumber.append(Int.random(in: 1...9))
    numbers.removeAll{ $0 == randomNumber[0]}
    for _ in 1..<3{
        let index = Int.random(in: 0..<numbers.count)
        randomNumber.append(numbers[index])
        numbers.remove(at:index)
    }
    return randomNumber
}

// 메인 함수
struct start{
    func main() {
        let target = Random()
        print("랜덤 숫자가 생성되었습니다.")
    
        // 게임 실행
        while true {
            print("숫자를 입력하세요")
            if let input = readLine() {
                let guess = input.compactMap {Int(String($0))}
                // 길이가 3이 아니거나 중복된 값이 있는지 확인
                if guess.count != 3 || Set(guess).count != 3 {
                    print("올바른 값을 입력해주세요")
                    continue
                }
                // check 함수를 통해 strike, ball값을 가져옴
                let (strike, ball) = check(guess: guess, target: target)
            
                // strike가 3일 경우 정답 출력 후 종료, 아닐 경우 strike, ball의 값을 출력
                if strike == 3{
                    print("정답입니다")
                    break
                } else {
                    print("\(strike) 스트라이크, \(ball) 볼")
                }
            }
        }
    }
}

//strike와 ball값 계산
func check(guess: [Int], target: [Int]) -> (Int, Int){
    var strike = 0
    var ball = 0
    
    for (i, j) in guess.enumerated(){
        if j == target[i]{
            strike += 1
        } else if target.contains(j){
            ball += 1
        }
    }
    return (strike, ball)
}


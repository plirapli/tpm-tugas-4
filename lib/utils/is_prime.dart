bool isPrime(int num, {int i = 2}) {
  if (num <= 2) {
    return num == 2;
  }
  if (num % i == 0) {
    return false;
  }
  if (i * i > num) {
    return true;
  }

  // Check for next divisor
  return isPrime(num, i: i + 1);
}

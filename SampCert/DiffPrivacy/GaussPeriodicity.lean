/-
Copyright (c) 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Jean-Baptiste Tristan
-/

import SampCert.DiffPrivacy.GaussBound
import SampCert.DiffPrivacy.GaussConvergence

theorem SG_1_periodic (ss μ : ℝ) (h : ss > 0) :
  (∑' (n : ℤ), sg' ss μ n) = ∑' (n : ℤ), sg' ss (μ + 1) n := by
  have A : ∀ n : ℤ, sg' ss (μ + 1) n = sg' ss μ (n - 1) := by
    intro n ; simp [sg']
    ring_nf
  conv => enter [2,1, n] ; rw [A]
  clear A

  have S1 : Summable fun (n : ℕ) => (sg' ss μ) ((n + 1) : ℤ) := sorry
  have S2 : Summable fun (n : ℕ) => (sg' ss μ) ((-(n + 1)) : ℤ) := sorry
  have X := @tsum_of_add_one_of_neg_add_one ℝ _ _ _ _ (fun (n : ℤ) => (sg' ss μ) n) S1 S2
  rw [X]
  clear X

  have S3 : Summable fun (n : ℕ) => (sg' ss μ) (((n + 1) : ℤ) - 1) := sorry
  have S4 : Summable fun (n : ℕ) => (sg' ss μ) ((((-(n + 1)) : ℤ) - 1)) := sorry
  have Y := @tsum_of_add_one_of_neg_add_one ℝ _ _ _ _ (fun (n : ℤ) => (sg' ss μ) (n - 1)) S3 S4
  rw [Y]
  clear Y

  simp only [Int.cast_add, Int.cast_natCast, Int.cast_one, Int.cast_zero, neg_add_rev,
    Int.reduceNeg, Int.cast_neg, add_sub_cancel_right, zero_sub]
  clear S1 S2 S3 S4

  have S5 : Summable fun (n : ℕ) => sg' ss μ (n : ℤ) := by
    apply GaussConvergence' μ ss h
  have X5 := @tsum_eq_zero_add ℝ _ _ _ _ (fun (n : ℕ) => (sg' ss μ) n) S5
  rw [X5]; clear X5 S5

  have S6 :  Summable fun (n : ℕ) => sg' ss μ (n + 1) := sorry
  have X6 := @tsum_eq_zero_add ℝ _ _ _ _ (fun (n : ℕ) => (sg' ss μ) (n + 1)) S6
  rw [X6]

  simp

  rw [X6] ; clear X6 S6

  have S7 : Summable fun (n : ℕ) => sg' ss μ (-1 + -(@Nat.cast ℝ AddMonoidWithOne.toNatCast n)) := sorry
  have X7 := @tsum_eq_zero_add ℝ _ _ _ _ (fun (n : ℕ) => (sg' ss μ) (-1 + -(@Nat.cast ℝ AddMonoidWithOne.toNatCast n ))) S7
  rw [X7] ; clear X7 S7

  simp

  ring_nf

  conv =>
    left
    left
    left
    rw [add_assoc]
    right
    rw [add_comm]

  ring_nf

  conv =>
    left
    left
    rw [add_assoc]
    right
    rw [add_comm]

  ring_nf

  have X : ∀ (b : ℕ), (2 : ℝ) + b = b + 1 + 1 := by
    intro b
    rw [add_comm]
    rw [add_assoc]
    congr
    ring_nf

  conv =>
    left
    left
    right
    right
    intro b
    rw [X]

  congr
  ext n
  congr 1
  ring_nf

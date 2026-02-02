import itertools
import statistics

number_dice_rolled = 6
number_dice_scored = 4
min_straight_length = 3
min_multiple_length = 2

def generate_dice_possibilities(num_dice, sides=6):
    # Create a list for each die: [1, 2, ..., sides]
    die_sides = range(1, sides + 1)
    # Use product to get the Cartesian product of the sides, N times
    all_rolls = list(itertools.product(die_sides, repeat=num_dice))
    return all_rolls

def find_optimal_score(dice_values, num_score=5):
    highest_value = 0
    best_arrangement = []
    permutations=list(itertools.permutations(dice_values,num_score))
    for perm in permutations:
        value = find_score(perm[:num_score])
        if value > highest_value:
            highest_value = value
            best_arrangement = perm[:num_score]
    # print(highest_value, best_arrangement)
    return highest_value


def find_score(dice_values):
    score_dice_sum = sum(dice_values)
    score_straights = score_straight_lengths(find_straight_lengths(dice_values))
    score_multiples = score_multiple_lengths(find_multiple_lengths(dice_values))
    return score_dice_sum + score_straights + score_multiples

# longer straight, more intense bonus
def score_straight_lengths(lengths):
    straight_sum = 0
    for l in lengths:
        for i in range(min_straight_length, l+1):
            straight_sum += i # TODO buff this
    return straight_sum


def score_multiple_lengths(lengths):
    multiple_sum = 0
    for l in lengths:
        for i in range(min_multiple_length, l+1):
            multiple_sum += i
    return multiple_sum


def find_straight_lengths(dice_values):
    straight_lengths = []
    current_straight_length = 0
    for i, value in enumerate(dice_values):
        if i + 1 < len(dice_values) and dice_values[i + 1] == value + 1:
            current_straight_length += 1
        else:
            if current_straight_length >= min_straight_length:
                straight_lengths.append(current_straight_length)
            current_straight_length = 0
    return straight_lengths


def find_multiple_lengths(dice_values):
    multiple_lengths = []
    current_multiple_length = 0
    for i, value in enumerate(dice_values):
        if i + 1 < len(dice_values) and dice_values[i + 1] == value:
            current_multiple_length += 1
        else:
            if current_multiple_length >= min_multiple_length:
                multiple_lengths.append(current_multiple_length)
            current_multiple_length = 0
    return multiple_lengths


all_possibilities = generate_dice_possibilities(number_dice_rolled)
# print(all_possibilities)
all_scores = []

for possibility in all_possibilities:
    score = find_optimal_score(possibility, number_dice_scored)
    all_scores.append(score)

print("Min: ", min(all_scores))
print("Max: ", max(all_scores))
print("Mean: ", statistics.mean(all_scores))

# print(find_score([1, 2, 2, 1, 3]))
# print(find_score([1, 1, 2, 3, 2]))

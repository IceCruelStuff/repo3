
[spmatrix, tokenlist, trainCategory] = readMatrix('MATRIX.TRAIN');

trainMatrix = full(spmatrix);
numTrainDocs = size(trainMatrix, 1);
numTokens = size(trainMatrix, 2);

% trainMatrix is now a (numTrainDocs x numTokens) matrix.
% Each row represents a unique document (email).
% The j-th column of the row $i$ represents the number of times the j-th
% token appeared in email $i$. 

% tokenlist is a long string containing the list of all tokens (words).
% These tokens are easily known by position in the file TOKENS_LIST

% trainCategory is a (1 x numTrainDocs) vector containing the true 
% classifications for the documents just read in. The i-th entry gives the 
% correct class for the i-th email (which corresponds to the i-th row in 
% the document word matrix).

% Spam documents are indicated as class 1, and non-spam as class 0.
% Note that for the SVM, you would want to convert these to +1 and -1.

pY = sum(trainCategory)/size(trainCategory,2);

%Get counts
numSpamWords = 0;
numNonSpamWords = 0;

spamWordCounts = ones(numTokens, 1);
nonSpamWordCounts = ones(numTokens, 1);

for i = 1:numTrainDocs
  for j = 1:numTokens
    if trainCategory(i) == 1 %spam
      numSpamWords = numSpamWords + trainMatrix(i,j);
      spamWordCounts(j) = spamWordCounts(j) + trainMatrix(i,j);
    else
      numNonSpamWords = numNonSpamWords + trainMatrix(i,j);
      nonSpamWordCounts(j) = nonSpamWordCounts(j) + trainMatrix(i,j);
    end 
  end
end

phi1 = zeros(numTokens, 1);
phi0 = zeros(numTokens, 1);

for j =1:numTokens
  ph1(j) = spamWordCounts(j)/(numSpamWords + 2);
  phi0(j) = nonSpamWordCounts(j)/(numNonSpamWords + 2);
end

save nb_phi1 phi1
save nb_phi0 phi0
save nb_pY pY
save nb_spamWordCounts spamWordCounts
save nb_nonSpamWordCounts nonSpamWordCounts
save nb_spamWords numSpamWords
save nb_nonSpamWords numNonSpamWords

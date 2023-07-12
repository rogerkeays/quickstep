# Quickstep: A language for writing music.

Quickstep is a text-based language for writing and transcribing music. It is also intended to assist memorisation by representing music structurally and using syntaxes that are also mnemonics. Each line in a *Quickstep* score represents a unit of musical information, so the score can easily be used to [generate flashcards](https://github.com/rogerkeays/workout/blob/main/make-flashcards.kt).

Here is a simple example, Andantino from Suzuki Violin Book 1:

    ==STRUCTURE

    practise-room : lesson exit : /4 : x90 : @42

    lesson : (suzuki violin) (suzuki break)
    exit : (listen help) (suzuki break)

    ==PHRASES

    suzuki : suzuki is the right method to take : w swsw ssx : 457 542 4202
    violin : on our small violin music we make : (suzuki) : 457 79Y 0Y97
    break : after we finish this, take a small break : (suzuki) : 457 9Y0 \5420
    listen : make sure that you listen each day : s sssw ssx : /4407 9Y07
    help : this will really help you to play : s ssss ssx : /20Y97542

## Structure

Traditional music notation spells out every note more or less sequentially from start to end. This is not how music works. Music has a hierarchical structure, so *Quickstep* uses hierarchical notation:

    section : [section | phrase]+ : metre? : tempo? : tonic?

Naming each section of music is an important step in interpreting and memorising the music. The general idea is to give section *place* names, and phrases *image* names, where the image name is a keyword from the lyrics. This turns all your musical scores into ad-hoc memory palaces.

Metre shows only the number of beats or compound beats in a bar. `/2` is two beats per bar, `/3` three, `/4` four. `/2/3` is two beats each divided into three. There is usually no need to use something like `/3/2` (three beats per bar divided into two) as this is not usually considered compound.

Tempo is the number of beats per minute. E.g. `x90`.

The tonic is considered to be relative to the instrument's tuning such that 'middle C' is `@40` for that instrument. The first number (4 in this example) represents the octave, and the second the tonic pitch. Pitches are numbered from 0-9 plus X and Y, representing semitones relative to C. In the example, the tonic is `@42` (middle D):

    practise-room : lesson exit : /4 : x90 : @42

## Phrases

A phrase consists of lyrics, rhythm, melody, mechanics and dynamics components. Experience has shown it is effective to keep this information together. Phrases are named after the image invoked by the lyrics. For music with no lyrics, the idea is create your own *mnemolyrics* for the purpose of memorisation and transcription (making sure you have the right number of notes in a phrase).

The syntax for phrases is:

    phrase : lyrics : rhythm : melody? : mechanics? : dynamics?

### Lyrics

An important function of the lyrics is to establish how many notes are in the phrase. Each syllable is one note. Sometimes it may be necessary to clarify where the sylabbles are using the following syntax:

    - syllable separator
    ~ broken vowel
    _ slurred notes

### Rhythm

There are some competing methods for writing rhythm. All of them are intended to be singable as a sort of rhythm solfege:

(1) **kick-step**: Each character represents on beat containing on of the following rhythms:

      mnemonic      rhythm onsets (see below)
    ----------------------------------
    s step          me      
    w walking       me  ce  
    g gallop-along  meneceke
    k kick              ce  
    c catching          ceke
    p point           ne    
    h hi                  ke
    C clapping        ne  ke
    l turn-left     mene    
    t throwing      me    ke
    r reaching        nece  
    P push-a-lot    menece  
    d drag-a-long   mene  ke
    b bit-limpy     me  ceke
    f falling-down    neceke
    3 trip-e-let    ma sa la  

(2) **meneceke**: Consonants define the note onset within the beat, vowels indicate the note length:

      onset
    ----------
    m downbeat
    n 1/4
    c 1/2   * pronounced 'ch'
    k 3/4
    s 1/3
    l 2/3

      length          pronounciation
    ----------------------------------
    a one beat
    i half beat
    e quarter beat
    u two beats      'oo' as in 'two'
    o four beats     'or' as in 'four'

Vowels can be combined to add lengths, e.g `ai` for one and a half beats.

(3) **manatada**: Most of the time note lengths are not needed, and it is more useful to record the notes position in the bar. This encoding uses consonants for note position in the bar and vowels for the onset within beats:

    position: m n t d = 1 2 3 4

      onset     prononciation
    ---------------------------
    a downbeat 'uh' as in 'one'
    u 1/4      'oo' as in 'two'
    i 1/2      'i:' as in 'three'
    o 3/4      'or' as in 'four'

### Melody

Melody is recorded using pitch numbers 0-9 and X and Y relative to the tonic. *Quickstep* does not distinguish between relative and absolute pitches because in music (as in life) *everything* is relative (except perhaps writing pitches in Hertz). A 'C' on a Bb trumpet is different to a 'C' on an Eb clarinet and a 'C' on a piano. You can say something like 'Concert C', but even that is relative to the standard A=440Hz.

`/` and `\` are used to indicate changes in the shape of the melody, going up or going down. This way we don't have to specify the octave number for each note. If a note is repeated there is no shape change. If you skip over an octave, use `//` or `\\`.

### Mechanics

Arbitrary at the moment. Useful for recording hand positions, up-bow/down-bows, fingering etc.

### Dynamics

Also unspecified for now. Intended for recording changes in the phrases expression.

## Harmony

Still working on it.

## Voices

Each voice has it's own score, either in the same file or a separate file. You would usually use the same structure section but with different phrases.

## Functions

The idea of *Quickstep* is to compact music down to it's essence. Often that means doing transforms on basic motifs and themes. Rather than write all that out in full, we use functions to describe them. The basic syntax is

    (phrase function? parameters?)

Where the most simple usage is with no function, which simply references the `data`. For example:

    suzuki : suzuki is the right method to take : w swsw ssx : 457 542 4202
    violin : on our small violin music we make : (suzuki) : 457 79Y 0Y97

The `violin` phrase has the same rhythm as the `suzuki` phrase.

Functions are not yet well defined, but you will be able to write your own, so go ahead and include any that sound good.

    (phrase drop 2)        // drop 2 notes off the end of a phrase
    (phrase dropFirst 2)   // drop 2 notes off the start of a phrase
    (phrase tranpose 7)    // transponse up 7 semitones

## Related Resources

  * [Workout](https://github.com/rogerkeays/workout): tools for your Ling-Ling workout.
  * [More stuff you never knew you wanted](https://rogerkeays.com).


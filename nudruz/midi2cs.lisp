(in-package :cm)

;; GETTING WARM!!!
(defobject midi2cs (i)
  ((ins :initform 1)
   duration
   amplitude
   pitch)
  (:parameters 
; ins 
	       time duration amplitude pitch))

(defun mtracks(file)
  (let ((tr))
    (with-open-io (io file :INPUT)
		(setf tr (midi-file-tracks io)))
    tr))

(defun midi-info (midif)
  (let ((nums '())
	(time '())
	(duration '())
	(amp '())
	(chan '())
	(tr (mtracks midif))
	(mf)
	(minfo '()))
    (loop for i from 0 below tr do
	  (setf mf (import-events midif :tracks i))
	  (map-subobjects #'(lambda (x) (push x nums)) mf :key #'midi-keynum :type 'midi)
	  (map-subobjects #'(lambda (x) (push x time)) mf :key #'object-time :type 'midi)
	  (map-subobjects #'(lambda (x) (push x duration)) mf :key #'midi-duration :type 'midi)
	  (map-subobjects #'(lambda (x) (push x amp)) mf :key #'midi-amplitude :type 'midi)
	  (map-subobjects #'(lambda (x) (push x chan)) mf :key #'midi-channel :type 'midi))
    (nreverse nums)
    (nreverse time)
    (nreverse duration)
    (nreverse amp)
    (nreverse chan)
    (loop for i from 0 below (length nums) do
	  (push (list  (nth i chan) 
		 (nth i time) (nth i duration) (nth i nums)
		      (nth i amp)) minfo))
    (nreverse minfo)))

(defprocess midi2sco (midifile)
  (let ((mididata (midi-info midifile))
	(d)
	(instr 1)
	(oct 0)
	(key 0)
	(ampl 0)
	(i (new midi2cs amplitude 64)))
    (process for j from 0 below (length mididata) do
	     (setf d (nth j mididata))
	     (setf instr 1)
;	     (setf instr (1+ (first d)))    ;;; only if you want to specify channel
	     (setf ampl (float (fifth d)))
	     (setf key (hertz (fourth d)))
	     (sv i ins instr
		 time (second d)
		 duration (third d)
		 amplitude ampl
		 pitch key)
	     (output i))))

    
(defun m2c(filein fileout)
  (events (midi2sco filein) fileout))

(m2c "/home/drew/midifiles/tocsound/a2.mid" "/home/drew/midifiles/scos/a2.sco")
(m2c "/home/drew/midifiles/tocsound/a3.mid" "/home/drew/midifiles/scos/a3.sco")
(m2c "/home/drew/midifiles/tocsound/aa2.mid" "/home/drew/midifiles/scos/aa2.sco")
(m2c "/home/drew/midifiles/tocsound/aa4.mid" "/home/drew/midifiles/scos/aa4.sco")
(m2c "/home/drew/midifiles/tocsound/aaa2.mid" "/home/drew/midifiles/scos/aaa2.sco")
(m2c "/home/drew/midifiles/tocsound/aaa3.mid" "/home/drew/midifiles/scos/aaa3.sco")
(m2c "/home/drew/midifiles/tocsound/aaa4.mid" "/home/drew/midifiles/scos/aaa4.sco")
(m2c "/home/drew/midifiles/tocsound/aaaa2.mid" "/home/drew/midifiles/scos/aaaa2.sco")
(m2c "/home/drew/midifiles/tocsound/aaaa3.mid" "/home/drew/midifiles/scos/aaaa3.sco")
(m2c "/home/drew/midifiles/tocsound/aaaa4.mid" "/home/drew/midifiles/scos/aaaa4.sco")
(m2c "/home/drew/midifiles/tocsound/b2.mid" "/home/drew/midifiles/scos/b2.sco")
(m2c "/home/drew/midifiles/tocsound/b3.mid" "/home/drew/midifiles/scos/b3.sco")
(m2c "/home/drew/midifiles/tocsound/b4.mid" "/home/drew/midifiles/scos/b4.sco")
(m2c "/home/drew/midifiles/tocsound/c2.mid" "/home/drew/midifiles/scos/c2.sco")
(m2c "/home/drew/midifiles/tocsound/c3.mid" "/home/drew/midifiles/scos/c3.sco")
(m2c "/home/drew/midifiles/tocsound/d2.mid" "/home/drew/midifiles/scos/d2.sco")
(m2c "/home/drew/midifiles/tocsound/d3.mid" "/home/drew/midifiles/scos/d3.sco")
(m2c "/home/drew/midifiles/tocsound/e2.mid" "/home/drew/midifiles/scos/e2.sco")
(m2c "/home/drew/midifiles/tocsound/f2.mid" "/home/drew/midifiles/scos/f2.sco")
(m2c "/home/drew/midifiles/tocsound/f3.mid" "/home/drew/midifiles/scos/f3.sco")
(m2c "/home/drew/midifiles/tocsound/f4.mid" "/home/drew/midifiles/scos/f4.sco")
(m2c "/home/drew/midifiles/tocsound/g2.mid" "/home/drew/midifiles/scos/g2.sco")
(m2c "/home/drew/midifiles/tocsound/h2.mid" "/home/drew/midifiles/scos/h2.sco")
(m2c "/home/drew/midifiles/tocsound/h3.mid" "/home/drew/midifiles/scos/h3.sco")
(m2c "/home/drew/midifiles/tocsound/h4.mid" "/home/drew/midifiles/scos/h4.sco")
(m2c "/home/drew/midifiles/tocsound/hh2.mid" "/home/drew/midifiles/scos/hh2.sco")
(m2c "/home/drew/midifiles/tocsound/hh3.mid" "/home/drew/midifiles/scos/hh3.sco")
(m2c "/home/drew/midifiles/tocsound/hh4.mid" "/home/drew/midifiles/scos/hh4.sco")
(m2c "/home/drew/midifiles/tocsound/hhh2.mid" "/home/drew/midifiles/scos/hhh2.sco")
(m2c "/home/drew/midifiles/tocsound/hhh3.mid" "/home/drew/midifiles/scos/hhh3.sco")
(m2c "/home/drew/midifiles/tocsound/hhhh2.mid" "/home/drew/midifiles/scos/hhhh2.sco")
(m2c "/home/drew/midifiles/tocsound/hhhh3.mid" "/home/drew/midifiles/scos/hhhh3.sco")
(m2c "/home/drew/midifiles/tocsound/hhhh4.mid" "/home/drew/midifiles/scos/hhhh4.sco")
(m2c "/home/drew/midifiles/tocsound/i2.mid" "/home/drew/midifiles/scos/i2.sco")
(m2c "/home/drew/midifiles/tocsound/ii3.mid" "/home/drew/midifiles/scos/ii3.sco")
(m2c "/home/drew/midifiles/tocsound/iii2.mid" "/home/drew/midifiles/scos/iii2.sco")
(m2c "/home/drew/midifiles/tocsound/iii4.mid" "/home/drew/midifiles/scos/iii4.sco")
(m2c "/home/drew/midifiles/tocsound/iii5.mid" "/home/drew/midifiles/scos/iii5.sco")
(m2c "/home/drew/midifiles/tocsound/l2.mid" "/home/drew/midifiles/scos/l2.sco")
(m2c "/home/drew/midifiles/tocsound/l4.mid" "/home/drew/midifiles/scos/l4.sco")
(m2c "/home/drew/midifiles/tocsound/ll3.mid" "/home/drew/midifiles/scos/ll3.sco")
(m2c "/home/drew/midifiles/tocsound/lll2.mid" "/home/drew/midifiles/scos/lll2.sco")
(m2c "/home/drew/midifiles/tocsound/lll4.mid" "/home/drew/midifiles/scos/lll4.sco")
(m2c "/home/drew/midifiles/tocsound/o2.mid" "/home/drew/midifiles/scos/o2.sco")
(m2c "/home/drew/midifiles/tocsound/o3.mid" "/home/drew/midifiles/scos/o3.sco")
(m2c "/home/drew/midifiles/tocsound/oo4.mid" "/home/drew/midifiles/scos/oo4.sco")
(m2c "/home/drew/midifiles/tocsound/oo5.mid" "/home/drew/midifiles/scos/oo5.sco")
(m2c "/home/drew/midifiles/tocsound/ooo2.mid" "/home/drew/midifiles/scos/ooo2.sco")
(m2c "/home/drew/midifiles/tocsound/ooo3.mid" "/home/drew/midifiles/scos/ooo3.sco")
(m2c "/home/drew/midifiles/tocsound/oooo2.mid" "/home/drew/midifiles/scos/oooo2.sco")
(m2c "/home/drew/midifiles/tocsound/oooo3.mid" "/home/drew/midifiles/scos/oooo3.sco")
(m2c "/home/drew/midifiles/tocsound/oooo4.mid" "/home/drew/midifiles/scos/oooo4.sco")
(m2c "/home/drew/midifiles/tocsound/oooo5.mid" "/home/drew/midifiles/scos/oooo5.sco")
(m2c "/home/drew/midifiles/tocsound/ooooo3.mid" "/home/drew/midifiles/scos/ooooo3.sco")
(m2c "/home/drew/midifiles/tocsound/ooooo4.mid" "/home/drew/midifiles/scos/ooooo4.sco")
(m2c "/home/drew/midifiles/tocsound/oooooo2.mid" "/home/drew/midifiles/scos/oooooo2.sco")
(m2c "/home/drew/midifiles/tocsound/oooooo3.mid" "/home/drew/midifiles/scos/oooooo3.sco")
(m2c "/home/drew/midifiles/tocsound/q2.mid" "/home/drew/midifiles/scos/q2.sco")
(m2c "/home/drew/midifiles/tocsound/q3.mid" "/home/drew/midifiles/scos/q3.sco")
(m2c "/home/drew/midifiles/tocsound/v2.mid" "/home/drew/midifiles/scos/v2.sco")
(m2c "/home/drew/midifiles/tocsound/v3.mid" "/home/drew/midifiles/scos/v3.sco")
(m2c "/home/drew/midifiles/tocsound/w2.mid" "/home/drew/midifiles/scos/w2.sco")
(m2c "/home/drew/midifiles/tocsound/w3.mid" "/home/drew/midifiles/scos/w3.sco")
(m2c "/home/drew/midifiles/tocsound/w4.mid" "/home/drew/midifiles/scos/w4.sco")
(m2c "/home/drew/midifiles/tocsound/w5.mid" "/home/drew/midifiles/scos/w5.sco")
(m2c "/home/drew/midifiles/tocsound/x2.mid" "/home/drew/midifiles/scos/x2.sco")
(m2c "/home/drew/midifiles/tocsound/x3.mid" "/home/drew/midifiles/scos/x3.sco")
(m2c "/home/drew/midifiles/tocsound/x5.mid" "/home/drew/midifiles/scos/x5.sco")


(m2c "/home/drew/midifiles/tocsound/percs/gp1.mid" "/home/drew/instruments/scos/flcyc/gp1.sco")
(m2c "/home/drew/midifiles/tocsound/percs/gp2.mid" "/home/drew/instruments/scos/flcyc/gp2.sco")
(m2c "/home/drew/midifiles/tocsound/percs/gp3.mid" "/home/drew/instruments/scos/flcyc/gp3.sco")
(m2c "/home/drew/midifiles/tocsound/percs/ip1.mid" "/home/drew/instruments/scos/flcyc/ip1.sco")
(m2c "/home/drew/midifiles/tocsound/percs/ip2.mid" "/home/drew/instruments/scos/flcyc/ip2.sco")
(m2c "/home/drew/midifiles/tocsound/percs/ip3.mid" "/home/drew/instruments/scos/flcyc/ip3.sco")
(m2c "/home/drew/midifiles/tocsound/percs/iiip1.mid" "/home/drew/instruments/scos/flcyc/iiip1.sco")
(m2c "/home/drew/midifiles/tocsound/percs/iiip2.mid" "/home/drew/instruments/scos/flcyc/iiip2.sco")
(m2c "/home/drew/midifiles/tocsound/percs/iiip3.mid" "/home/drew/instruments/scos/flcyc/iiip3.sco")


(m2c "that2.mid" "that2.sco")

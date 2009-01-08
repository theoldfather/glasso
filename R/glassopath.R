glassopath=function (s, rholist=NULL, thr = 1e-04, maxit = 10000, approx = FALSE
, 
                penalize.diagonal = TRUE,  w.init = NULL, 
                wi.init = NULL, trace = FALSE) 
{
        n = nrow(s)
if(is.null(rholist)){
      rholist=seq(max(abs(s))/10,max(abs(s)),length=10)
  }
rholist=sort(rholist)
                itrace = 1 * trace
                ipen = 1 * (penalize.diagonal)
                ia = 1 * approx
                rho=xx=ww=matrix(0,n,n)
                nrho=length(rholist)
                beta=what=array(0,c(n,n,nrho))
                jerrs=rep(0,nrho)
                mode(rholist) = "single"
                mode(nrho) = "integer"
                mode(rho) = "single"
                mode(s) = "single"
                mode(ww) = "single"
                mode(xx) = "single"
                mode(n) = "integer"
                mode(maxit) = "integer"
                mode(ia) = "integer"
                mode(itrace) = "integer"
                mode(ipen) = "integer"
                mode(thr) = "single"
                mode(beta) = "single"
                mode(what) = "single"
                mode(jerrs) = "integer"

        junk <- .Fortran("glassopath", beta=beta,what=what,jerrs=jerrs,rholist,nrho,n, s, rho, ia,        itrace, ipen,
        thr, maxit = maxit, ww = ww, xx = xx, niter = integer(1), 
        del = single(1), ierr = integer(1), PACKAGE="glasso")

    xx = array(junk$beta,  c(n,n,nrho))
    what = array(junk$what,  c(n,n,nrho))
    return(list(w=what, wi = xx, 
        approx = approx, rholist=rholist, errflag = junk$jerrs))
}

const chai = require('chai');
const chaiHttp = require('chai-http');
const sinon = require('sinon');
const sinonChai = require('sinon-chai');
const proxyquire = require('proxyquire');

process.env.BACKEND_URL = 'fake-url';
const requestStub = sinon.stub();
const server = proxyquire('../server', { 'request-promise' : requestStub} );

chai.use(chaiHttp);
chai.use(sinonChai);
chai.should();

describe('Endpoint test', () => {
    beforeEach(() => {
        requestStub.resolves({ name: 'test-name' });
    });
    describe('Home', () => {
        it('Should have called the backend', (done) => {
            chai.request(server)
                .get('/')
                .end((err, res) => {
                    requestStub.should.have.been.calledWith({ uri: 'fake-url/user', json: true });
                    done();
                });
        });

        it('Should have the user name in the returned html', (done) => {
            chai.request(server)
                .get('/')
                .end((err, res) => {
                    res.should.have.status(200);
                    res.text.should.contain('test-name');
                    done();
                });
        });
    });
});
